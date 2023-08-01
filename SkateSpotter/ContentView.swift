import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SpotList()
                .tabItem {
                    Label("Discover", systemImage: "list.bullet")
                }
            SpotMap()
                .tabItem {
                    Label("Locations", systemImage: "mappin.and.ellipse")
                }
            AddSpotForm()
                .tabItem {
                    Label("Add New Spot", systemImage: "square.and.pencil")
                }
        }
        .accentColor(Color(.secondary))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
