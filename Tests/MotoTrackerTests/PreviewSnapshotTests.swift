import XCTest
import SnapshotTesting
import SwiftUI
@testable import MotoTracker

final class PreviewSnapshotTests: XCTestCase {

    override func invokeTest() {
        // En CI on veut toujours régénérer l'image (pas comparer à une référence)
        withSnapshotTesting(record: .all) {
            super.invokeTest()
        }
    }

    func testHomeScreen() {
        let view = HomeView(locationManager: LocationManager(), tripStore: TripStore())
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }

    func testHistoryScreenEmpty() {
        let view = HistoryView(tripStore: TripStore())
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }
}
