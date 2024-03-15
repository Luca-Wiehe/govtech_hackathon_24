import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            BackgroundView {
                VStack(spacing: 20) {
                    ProfileImageView()
                    UserInfoView()
                    ActionButtonsView()
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding(.horizontal, 16)
            }
            .navigationBarHidden(true) // Optionally hide the navigation bar
        }
    }
}

struct BackgroundView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.7), Color.red]),
                           startPoint: .top,
                           endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            content
        }
    }
}

struct ProfileImageView: View {
    var body: some View {
        Image("profileImage2")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
    }
}

struct UserInfoView: View {
    var body: some View {
        VStack {
            Text("Nina Gammenthaler")
                .fontWeight(.heavy)
                .font(.title)
            
            Text("Bundeskanzlei")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.top, -12)
            
            Text("Make sure that you find the right people. Talk to our ChatGPT-powered Chatbot to find people that suit your needs.")
                .padding(.horizontal)
                .padding(.top, 8)
        }
    }
}

struct ActionButtonsView: View {
    var body: some View {
        VStack(spacing: 16) {
            ChatGPTButton()
            
            TimePreferencesButton()
            
            SynchronizeCalendarButton()
        }
    }
}

struct ChatGPTButton: View {
    var body: some View {
        NavigationLink(destination: ChatbotView()) {
            HStack {
                Text("Let ChatGPT complete your profile")
                    .underline()
                    .foregroundColor(.red)
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
}


struct TimePreferencesButton: View {
    var body: some View {
        NavigationLink(destination: TimePreferencesView()) {
            ButtonContent(imageName: "gear", buttonText: "Profile Preferences", buttonColor: .red)
        }
    }
}

struct SynchronizeCalendarButton: View {
    var body: some View {
        Button(action: {
            // Action for synchronizing Outlook calendar
        }) {
            HStack {
                Image("outlookIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
                    .padding(.trailing, 8)
                Text("Synchronize Outlook Calendar")
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(.blue)
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.blue, lineWidth: 2))
        }
    }
}

struct ButtonContent: View {
    var imageName: String
    var buttonText: String
    var buttonColor: Color
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32)
                .padding(.trailing, 8)
            Text(buttonText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .foregroundColor(buttonColor)
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(buttonColor, lineWidth: 2))
    }
}

// Preview provider
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(TimeManager())
    }
}
