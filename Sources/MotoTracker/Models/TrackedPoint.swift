import Foundation
import CoreLocation

struct TrackedPoint: Codable, Identifiable {
    var id = UUID()
    let latitude: Double
    let longitude: Double
    let timestamp: Date

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    init(coordinate: CLLocationCoordinate2D, timestamp: Date = Date()) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
        self.timestamp = timestamp
    }
}
