import SwiftUI

struct SwipeView: View {
    
    @EnvironmentObject var navigationController: NavigationController
    
    // Sample list of strings to be displayed on the cards
    @State var cardContents: [String] = ["First Person", "Second Person", "Third Person", "Fourth Person"]
    @State private var offset = CGSize.zero
    @State private var degree: Double = 0
    
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
                    ZStack {
                        ForEach(cardContents.indices.reversed(), id: \.self) { index in
                            CardView(content: cardContents[index])
                                .offset(x: 0, y: CGFloat(index) * 10)
                                .offset(index == cardContents.count - 1 ? offset : .zero)
                                .rotationEffect(.degrees(index == cardContents.count - 1 ? degree : 0))
                                .gesture(
                                    index == cardContents.count - 1 ?
                                        DragGesture()
                                        .onChanged { gesture in
                                            offset = gesture.translation
                                            degree = Double(gesture.translation.width / 20)
                                        }
                                        .onEnded { _ in
                                            withAnimation {
                                                if abs(offset.width) > 100 {
                                                    cardContents.removeLast()
                                                }
                                                
                                                offset = .zero
                                                degree = 0
                                            }
                                        } : nil
                                )
                        }
                    }
                    Spacer()
                }
            )
    }
}

struct CardView: View {
    var content: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(20)
                .shadow(radius: 5)
            Text(content)
                .font(.title)
                .foregroundColor(.black)
        }
        .frame(width: 300, height: 400)
    }
}

struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeView()
    }
}
