import Foundation
import CoreLocation
import Combine

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()

    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var isTracking = false
    @Published var currentTrip: Trip?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.activityType = .automotiveNavigation
        manager.allowsBackgroundLocationUpdates = true
        manager.pausesLocationUpdatesAutomatically = false
    }

    func requestPermission() {
        manager.requestAlwaysAuthorization()
    }

    func startTrip() {
        currentTrip = Trip(startDate: Date())
        isTracking = true
        manager.startUpdatingLocation()
    }

    /// Arrête le trajet en cours et le renvoie pour qu'il soit sauvegardé dans l'historique.
    func stopTrip() -> Trip? {
        manager.stopUpdatingLocation()
        isTracking = false
        currentTrip?.endDate = Date()
        let finished = currentTrip
        currentTrip = nil
        return finished
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location.coordinate
        if isTracking {
            currentTrip?.points.append(TrackedPoint(coordinate: location.coordinate, timestamp: location.timestamp))
        }
    }
}
