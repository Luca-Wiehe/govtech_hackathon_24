import SwiftUI

struct ContentView: View {
    @EnvironmentObject var navigationController: NavigationController

    var body: some View {
        NavigationStack {
            switch navigationController.selection {
            case 0:
                StartView()
            case 2:
                GrantAccessView()
            default:
                HomeView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(NavigationController())
}
