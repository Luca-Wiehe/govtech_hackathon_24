import Foundation

class TimeManager: ObservableObject {
    // Dictionary to hold start and end times for each meeting type
    @Published var meetingTimes: [TimeOption: (startTime: String, endTime: String)] = [:]

    // Function to update the times for a specific meeting type
    func updateTimes(for type: TimeOption, startTime: String, endTime: String) {
        meetingTimes[type] = (startTime, endTime)
    }
}
