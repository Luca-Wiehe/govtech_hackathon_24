import SwiftUI

struct MatchView: View {
    
    @EnvironmentObject var navigationController: NavigationController

    @State private var selectedCity: String = "Zurich"
    @State private var selectedLanguage: String = "English"
    @State private var selectedInteractionType: String = "Coffee Chat"
    @State private var isSimilar: Bool = true

    private let cities = ["Zurich", "Geneva", "Basel", "Lausanne", "Bern", "Winterthur", "Lucerne", "St. Gallen", "Lugano"]
    private let languages = ["French", "Italian", "German", "English"]
    private let interactionTypes = ["Coffee Chat", "Project-Related", "Interest-Based"]

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.7), Color.red]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Text("Select Matching Criteria")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 20)

                    Spacer()

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Location")
                            .font(.headline)
                            .foregroundColor(.black)
                        Picker("Location", selection: $selectedCity) {
                            ForEach(cities, id: \.self) { city in
                                Text(city).tag(city)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())

                        Text("Language")
                            .font(.headline)
                            .foregroundColor(.black)
                        Picker("Language", selection: $selectedLanguage) {
                            ForEach(languages, id: \.self) { language in
                                Text(language).tag(language)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                        Text("Interaction Type")
                            .font(.headline)
                            .foregroundColor(.black)
                        Picker("Interaction Type", selection: $selectedInteractionType) {
                            ForEach(interactionTypes, id: \.self) { type in
                                Text(type).tag(type)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())

                        Text("Meet new people who are...")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.top)

                        HStack(spacing: 10) {
                            Button(action: { isSimilar = true }) {
                                Text("Similar")
                                    .foregroundColor(isSimilar ? Color.red : Color.black)
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.red, lineWidth: isSimilar ? 2 : 0)
                                    )
                                    .background(isSimilar ? Color.white : Color.clear)
                                    .cornerRadius(5)
                            }

                            Button(action: { isSimilar = false }) {
                                Text("Dissimilar")
                                    .foregroundColor(!isSimilar ? Color.red : Color.black)
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.red, lineWidth: !isSimilar ? 2 : 0)
                                    )
                                    .background(!isSimilar ? Color.white : Color.clear)
                                    .cornerRadius(5)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()

                    Spacer()
                    
                    Button(action: {
                        navigationController.selection = 3
                    }) {
                        HStack {
                            Text("Find a Match")
                                .foregroundColor(Color.red)
                                .bold()
                            Image(systemName: "arrow.right")
                                .foregroundColor(Color.red)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                    .padding()

                    Spacer()
                }
            }
        }
    }
}

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        MatchView()
            .environmentObject(NavigationController())
    }
}
