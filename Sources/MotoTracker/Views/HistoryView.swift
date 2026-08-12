import SwiftUI

struct HistoryView: View {
    @ObservedObject var tripStore: TripStore

    var body: some View {
        NavigationStack {
            List {
                ForEach(tripStore.trips) { trip in
                    NavigationLink(destination: TripDetailView(trip: trip)) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(trip.startDate.formatted(date: .abbreviated, time: .shortened))
                                .font(.subheadline)
                            HStack {
                                Text(String(format: "%.2f km", trip.distanceKm))
                                Spacer()
                                Text(formattedDuration(trip.duration))
                            }
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        }
                    }
                }
                .onDelete(perform: tripStore.delete)
            }
            .navigationTitle("Historique")
            .overlay {
                if tripStore.trips.isEmpty {
                    ContentUnavailableView(
                        "Aucun trajet",
                        systemImage: "map",
                        description: Text("Démarre un trajet depuis l'onglet Trajet.")
                    )
                }
            }
        }
    }

    private func formattedDuration(_ interval: TimeInterval) -> String {
        let minutes = Int(interval) / 60
        return "\(minutes) min"
    }
}

#Preview {
    HistoryView(tripStore: TripStore())
}
