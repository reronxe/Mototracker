import Foundation
import CoreLocation

struct Trip: Codable, Identifiable {
    var id = UUID()
    var startDate: Date
    var endDate: Date?
    var points: [TrackedPoint] = []

    var duration: TimeInterval {
        guard let endDate else { return Date().timeIntervalSince(startDate) }
        return endDate.timeIntervalSince(startDate)
    }

    var distanceMeters: Double {
        guard points.count > 1 else { return 0 }
        var total: CLLocationDistance = 0
        for i in 1..<points.count {
            let a = CLLocation(latitude: points[i - 1].latitude, longitude: points[i - 1].longitude)
            let b = CLLocation(latitude: points[i].latitude, longitude: points[i].longitude)
            total += a.distance(from: b)
        }
        return total
    }

    var distanceKm: Double { distanceMeters / 1000 }
}
