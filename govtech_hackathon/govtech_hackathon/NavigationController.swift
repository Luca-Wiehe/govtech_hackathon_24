import Combine
import SwiftUI

class NavigationController: ObservableObject {
    @Published var selection: Int = 0
}
