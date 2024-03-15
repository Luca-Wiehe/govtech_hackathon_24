import Foundation

class PersonalInformationManager: ObservableObject {
    @Published var personalInfo: PersonalInformation = PersonalInformation()

    func updatePersonalInformation(aboutMe: String, responsibilities: String, interests: String) {
        personalInfo = PersonalInformation(aboutMe: aboutMe, responsibilities: responsibilities, interests: interests)
    }
}

struct PersonalInformation {
    var aboutMe: String = ""
    var responsibilities: String = ""
    var interests: String = ""
}
