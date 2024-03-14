import SwiftUI

// Represents a single card view
struct CardView: View {
    var content: String
    
    var body: some View {
        Text(content)
            .padding()
            .frame(width: 300, height: 400)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 2)
            )
    }
}

struct SwipeView: View {
    
    @EnvironmentObject var navigationController: NavigationController
    
    @State var cardContents: [String] = ["First Person", "Second Person", "Third Person", "Fourth Person"]
    @State private var offset = CGSize.zero
    
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
                    
                    if !cardContents.isEmpty {
                        ZStack {
                            CardView(content: cardContents.last!)
                                .offset(offset)
                                .gesture(
                                    DragGesture()
                                        .onChanged { gesture in
                                            self.offset = gesture.translation
                                        }
                                        .onEnded { _ in
                                            if abs(self.offset.width) > 100 {
                                                cardContents.removeLast()
                                            }
                                            self.offset = .zero
                                        }
                                )
                                .animation(.easeInOut, value: offset)
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
