import SwiftUI

struct PersonalInformationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var personalInfoManager: PersonalInformationManager

    @State private var aboutMe: String = ""
    @State private var responsibilities: String = ""
    @State private var interests: String = ""
    @State private var activeField: ActiveField?

    var body: some View {
        VStack {
            Text("Personal Information")
                .font(.headline)
                .padding(.top)
                .frame(maxWidth: .infinity)

            ScrollView {
                VStack(alignment: .leading) {
                    Group {
                        Text("About Me")
                            .font(.headline)
                        TextEditor(text: $aboutMe)
                            .frame(height: 100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(activeField == .aboutMe ? Color.red : Color.gray, lineWidth: 1)
                            )
                            .onTapGesture {
                                self.activeField = .aboutMe
                            }
                    }

                    Group {
                        Text("Responsibilities")
                            .font(.headline)
                        CustomTextField(text: $responsibilities, activeField: $activeField, currentField: .responsibilities)
                    }

                    Group {
                        Text("Interests")
                            .font(.headline)
                        CustomTextField(text: $interests, activeField: $activeField, currentField: .interests)
                    }
                }
                .padding(16)
            }
            
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.05)]), startPoint: .top, endPoint: .bottom))
                .frame(height: 10)
                .edgesIgnoringSafeArea(.horizontal)

            Spacer()

            Button(action: {
                personalInfoManager.updatePersonalInformation(aboutMe: aboutMe, responsibilities: responsibilities, interests: interests)
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding(.bottom)
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: UIScreen.main.bounds.width - 32, maxHeight: 500)
        .background(Color.white)
        .cornerRadius(25.0)
        .onAppear {
            // Load the stored information if available
            aboutMe = personalInfoManager.personalInfo.aboutMe
            responsibilities = personalInfoManager.personalInfo.responsibilities
            interests = personalInfoManager.personalInfo.interests
        }
    }
}

struct CustomTextField: View {
    @Binding var text: String
    @Binding var activeField: ActiveField?
    var currentField: ActiveField
    
    var body: some View {
        TextField("", text: $text)
            .padding()
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(activeField == currentField ? Color.red : Color.gray, lineWidth: 1)
            )
            .onTapGesture {
                self.activeField = currentField
            }
    }
}

enum ActiveField {
    case aboutMe, responsibilities, interests
}


#Preview {
    PersonalInformationView()
        .environmentObject(PersonalInformationManager())
}
