import Foundation

struct Person: Identifiable {
    var id = UUID()
    var name: String
    var profileImage: String
    var department: String
    var interests: [String]
    var responsibilities: String
}
