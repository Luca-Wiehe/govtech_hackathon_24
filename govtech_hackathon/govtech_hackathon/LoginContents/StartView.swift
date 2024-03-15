import SwiftUI

struct StartView: View {
    @EnvironmentObject var navigationController: NavigationController

    var body: some View {
        NavigationStack {
            ZStack {
                // Red gradient background
                LinearGradient(gradient: Gradient(colors: [Color.red, Color.red.opacity(0.8)]), startPoint: .bottom, endPoint: .top)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    // Trigger for showing GrantAccessView
                    Button(action: {
                        navigationController.selection = 2
                    }) {
                        HStack {
                            Image(systemName: "link")
                                .foregroundColor(.red)
                                .bold()
                            Text("Login with AdminDirectory")
                                .foregroundColor(.red)
                                .bold()
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                    }

                    Spacer()
                }
                
                VStack {
                    HStack {
                        Text("Welcome to GovMatch!")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding(.leading)
                            .padding(.top, 50)
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    StartView()
}
