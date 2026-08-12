import Foundation

final class TripStore: ObservableObject {
    @Published var trips: [Trip] = []

    private let fileURL: URL = {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return dir.appendingPathComponent("trips.json")
    }()

    init() {
        load()
    }

    func add(_ trip: Trip) {
        trips.insert(trip, at: 0)
        save()
    }

    func delete(at offsets: IndexSet) {
        trips.remove(atOffsets: offsets)
        save()
    }

    private func load() {
        guard let data = try? Data(contentsOf: fileURL) else { return }
        trips = (try? JSONDecoder().decode([Trip].self, from: data)) ?? []
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(trips) else { return }
        try? data.write(to: fileURL)
    }
}
