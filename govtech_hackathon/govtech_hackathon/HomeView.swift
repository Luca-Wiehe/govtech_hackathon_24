import SwiftUI

struct HomeView: View {
    // State variable to track the current selection
    @State private var selection = 1
    
    init() {
        // Set tab bar's background color
        UITabBar.appearance().backgroundColor = UIColor.white.withAlphaComponent(0.7)

        // Set the tab bar item's active (selected) tint color
        UITabBar.appearance().tintColor = UIColor.red

        // Set the tab bar item's inactive (unselected) tint color
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }

    var body: some View {
        TabView(selection: $selection) {
            MatchView()
                .tabItem {
                    Label("Match", systemImage: "person.3.fill")
                        .foregroundColor(.white)
                }
                .tag(1)
            
            CalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                        .foregroundColor(.white)
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                        .foregroundColor(.white)
                }
                .tag(3)
        }
        .accentColor(Color.red)
        .edgesIgnoringSafeArea(.top)
    }
}

// Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
