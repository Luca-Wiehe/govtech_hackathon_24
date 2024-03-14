import SwiftUI

struct HomeView: View {
    // State variable to track the current selection
    @State private var selection = 1
    
    var body: some View {
        // Using VStack to place the TabView at the bottom
        VStack {
            Spacer() // Pushes everything to the bottom
            
            // TabView definition
            TabView(selection: $selection) {
                // Match tab
                MatchView()
                    .tabItem {
                        Label("Match", systemImage: "person.3.fill")
                    }
                    .tag(1) // Unique identifier for this tab
                
                // Calendar tab
                CalendarView()
                    .tabItem {
                        Label("Calendar", systemImage: "calendar")
                    }
                    .tag(2) // Unique identifier for this tab
                
                // Profile tab
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
                    .tag(3) // Unique identifier for this tab
            }
            .accentColor(.red) // Highlights the current selection in red
        }
    }
}

#Preview {
    HomeView()
}
