import SwiftUI
import MapKit

struct TripDetailView: View {
    let trip: Trip
    @State private var cameraPosition: MapCameraPosition

    init(trip: Trip) {
        self.trip = trip
        if let first = trip.points.first {
            _cameraPosition = State(initialValue: .region(
                MKCoordinateRegion(
                    center: first.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
            ))
        } else {
            _cameraPosition = State(initialValue: .automatic)
        }
    }

    var body: some View {
        VStack {
            Map(position: $cameraPosition) {
                MapPolyline(coordinates: trip.points.map { $0.coordinate })
                    .stroke(.blue, lineWidth: 4)
            }
            .frame(height: 300)

            List {
                LabeledContent("Distance", value: String(format: "%.2f km", trip.distanceKm))
                LabeledContent("Durée", value: "\(Int(trip.duration) / 60) min")
                LabeledContent("Date", value: trip.startDate.formatted(date: .long, time: .shortened))
            }
        }
        .navigationTitle("Détail du trajet")
    }
}

#Preview {
    TripDetailView(trip: Trip(
        startDate: .now,
        endDate: .now.addingTimeInterval(600),
        points: [
            TrackedPoint(coordinate: .init(latitude: 46.2, longitude: 6.15)),
            TrackedPoint(coordinate: .init(latitude: 46.21, longitude: 6.16))
        ]
    ))
}
