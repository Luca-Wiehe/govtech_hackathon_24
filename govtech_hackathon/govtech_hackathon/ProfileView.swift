import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.7), Color.red]),
                           startPoint: .top,
                           endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Image("profileImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                
                Text("Luca Wiehe")
                    .fontWeight(.heavy)
                    .font(.title)
                    .padding(.bottom, -16)
                
                Text("Department of Finance")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("Make sure that you find the right people. Talk to our ChatGPT-powered Chatbot to find people that suit your needs.")
                    .padding(.horizontal)
                
                HStack {
                    Button(action: {
                        // Action for filling the questionnaire
                    }) {
                        Text("Fill questionnaire")
                            .underline()
                            .foregroundColor(.red)
                    }
                    Spacer() // Pushes the button to the left
                }
                .padding(.leading, 20)
                .padding(.top, -16)
                .padding(.bottom, 32)
                
                Button(action: {
                    // Action for synchronizing Outlook calendar
                }) {
                    HStack {
                        Image("outlookIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 42, height: 42)
                        Text("Synchronize Outlook calendar")
                    }
                    .foregroundColor(.blue)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.blue, lineWidth: 2))
                }
                .padding(.bottom, 32)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
            .padding(.horizontal, 16)
        }
    }
}

// Preview provider
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
