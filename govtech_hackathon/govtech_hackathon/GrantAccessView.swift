import SwiftUI

struct GrantAccessView: View {
    @EnvironmentObject var navigationController: NavigationController

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.red.opacity(0.8)]), startPoint: .bottom, endPoint: .top)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                Spacer()
                
                VStack(alignment: .center, spacing: 0) {
                    Text("Please confirm that you want to grant GovMatch access to your AdminDirectory Data")
                        .foregroundColor(.black)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button(action: {
                        navigationController.selection = 1
                        print("navigationController.selection: \(navigationController.selection)")
                    }) {
                        Text("Confirm")
                            .bold()
                            .foregroundColor(.green)
                            .padding(.vertical)
                    }
                    .frame(width: 180)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.green, lineWidth: 2)
                    )
                    .cornerRadius(40)
                    
                    Button(action: {
                        navigationController.selection = 0
                        print("navigationController.selection: \(navigationController.selection)")
                    }) {
                        Text("Reject")
                            .bold()
                            .foregroundColor(.red)
                            .underline()
                            .padding(.vertical)
                    }
                    .frame(width: 180)
                }
                .background(Color.white)
                .cornerRadius(12)
                .padding()
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            navigationController.selection = 0
        }) {
            Image(systemName: "arrow.left")
                .foregroundColor(.white)
        })
        .onAppear {
            UINavigationBar.appearance().tintColor = .white
        }
    }
}

struct GrantAccessView_Previews: PreviewProvider {
    static var previews: some View {
        GrantAccessView()
            .environmentObject(NavigationController())
    }
}
