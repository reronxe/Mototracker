import SwiftUI
import MapKit

struct HomeView: View {
    @ObservedObject var locationManager: LocationManager
    @ObservedObject var tripStore: TripStore
    @State private var cameraPosition: MapCameraPosition = .automatic

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Map(position: $cameraPosition) {
                    if let trip = locationManager.currentTrip, trip.points.count > 1 {
                        MapPolyline(coordinates: trip.points.map { $0.coordinate })
                            .stroke(.blue, lineWidth: 4)
                    }
                    if let location = locationManager.currentLocation {
                        Annotation("Moi", coordinate: location) {
                            Circle().fill(.blue).frame(width: 14, height: 14)
                        }
                    }
                }
                .ignoresSafeArea(edges: .top)

                VStack(spacing: 8) {
                    if let trip = locationManager.currentTrip {
                        Text(String(format: "%.2f km", trip.distanceKm))
                            .font(.headline)
                    }
                    Button(action: toggleTracking) {
                        Text(locationManager.isTracking ? "Arrêter le trajet" : "Démarrer le trajet")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(locationManager.isTracking ? Color.red : Color.blue)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding()
                .background(.thinMaterial)
            }
            .navigationTitle("Trajet")
            .onAppear { locationManager.requestPermission() }
        }
    }

    private func toggleTracking() {
        if locationManager.isTracking {
            if let finished = locationManager.stopTrip() {
                tripStore.add(finished)
            }
        } else {
            locationManager.startTrip()
        }
    }
}

#Preview {
    HomeView(locationManager: LocationManager(), tripStore: TripStore())
}
