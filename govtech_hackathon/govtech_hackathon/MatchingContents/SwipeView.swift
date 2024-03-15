import SwiftUI

struct CardView: View {
    var person: Person
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Spacer()
                Image(person.profileImage) // Make sure this name corresponds with your asset names
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                Spacer()
            }
            .padding(.bottom, 5)
            
            HStack {
                Spacer()
                Text(person.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding([.bottom, .horizontal])
                Spacer()
            }

            Text(person.department)
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.bottom, 5)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("Interests: \(person.interests.joined(separator: ", "))")
                .font(.body)
                .padding(.bottom, 2)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("Responsibilities: \(person.responsibilities)")
                .font(.body)
                .padding(.bottom)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical)
        .padding(.horizontal, 32)
        .frame(width: 350, height: 500)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}




struct SwipeView: View {
    
    @EnvironmentObject var navigationController: NavigationController
    
    @State var people: [Person] = [
        Person(name: "Nina Gammenthaler", profileImage: "profileImage2", department: "Bundeskanzlei", interests: ["Gardening", "Baking"], responsibilities: "AI,CloudGovernance"),
        Person(name: "Lukas Willi", profileImage: "profileImage3", department: "Strategy & Tech", interests: ["Fitness", "Dog"], responsibilities: "Generative AI"),
        Person(name: "Viktor Rossi", profileImage: "profileImage4", department: "Bundeskanzlei", interests: ["Politics", "GEVER"], responsibilities: "All"),
    ]
    
    @State private var offset = CGSize.zero // Tracks the swipe gesture
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.7), .red]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            .overlay(
                VStack {
                    HStack {
                        Button(action: {
                            navigationController.selection = 1
                        }) {
                            Image(systemName: "arrow.left")
                                .foregroundColor(.white)
                                .padding()
                        }
                        Spacer()
                    }
                    Spacer()
                    if !people.isEmpty {
                        ZStack {
                            CardView(person: people.last!)
                                .offset(offset)
                                .gesture(
                                    DragGesture()
                                        .onChanged { gesture in
                                            self.offset = gesture.translation
                                        }
                                        .onEnded { _ in
                                            if abs(self.offset.width) > 100 {
                                                people.removeLast()
                                            }
                                            self.offset = .zero
                                        }
                                )
                                .animation(.easeInOut, value: offset)
                        }
                        
                        if offset.width != 0 {
                            Text(offset.width > 0 ? "Interested" : "Not Interested")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Capsule())
                                .transition(.opacity)
                                .animation(.easeInOut, value: offset.width)
                        }
                    }
                    Spacer()
                }
            )
    }
}

struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeView().environmentObject(NavigationController())
    }
}
