import SwiftUI

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var tripStore = TripStore()

    var body: some View {
        TabView {
            HomeView(locationManager: locationManager, tripStore: tripStore)
                .tabItem { Label("Trajet", systemImage: "map") }

            HistoryView(tripStore: tripStore)
                .tabItem { Label("Historique", systemImage: "clock") }
        }
    }
}

#Preview {
    ContentView()
}
