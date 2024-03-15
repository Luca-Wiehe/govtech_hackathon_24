import SwiftUI

struct TimePreferencesView: View {
    @EnvironmentObject var timeManager: TimeManager
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedTime: TimeOption = .coffeeChat
    @State private var startHour: String = ""
    @State private var startMinute: String = ""
    @State private var endHour: String = ""
    @State private var endMinute: String = ""

    var body: some View {
        BackgroundView {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.white)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 500)
                        .overlay(
                            VStack {
                                Text("Select a Meeting Time")
                                    .font(.headline)
                                    .padding(.top, 20)
                                    .padding(.bottom, 20)
                                
                                HStack(spacing: 10) {
                                    ForEach(TimeOption.allCases, id: \.self) { option in
                                        Button(action: {
                                            self.selectedTime = option
                                            updateFieldsForSelectedTime()
                                        }) {
                                            Text(option.rawValue)
                                                .foregroundColor(self.selectedTime == option ? .white : .red)
                                                .padding()
                                                .frame(maxWidth: .infinity, minHeight: 50)
                                                .background(self.selectedTime == option ? Color.red : .clear)
                                                .cornerRadius(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(Color.red, lineWidth: 2)
                                                )
                                                .fixedSize(horizontal: false, vertical: true)
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                
                                Group {
                                    Text("Choose preferred start time")
                                        .font(.headline)
                                    TimeInputView(hour: $startHour, minute: $startMinute)
                                    
                                    Text("Choose preferred end time")
                                        .font(.headline)
                                    TimeInputView(hour: $endHour, minute: $endMinute)
                                }
                                .padding(.top, 10)
                                
                                Spacer()
                                
                                Button(action: {
                                    let startTime = "\(startHour):\(startMinute)"
                                    let endTime = "\(endHour):\(endMinute)"
                                    timeManager.updateTimes(for: selectedTime, startTime: startTime, endTime: endTime)
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    Text("Save")
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .frame(width: 200, height: 50)
                                        .background(Color.red)
                                        .cornerRadius(10)
                                }
                                .padding(.bottom, 30)
                            }
                            .padding(.horizontal)
                        )
                    Spacer()
                }
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            updateFieldsForSelectedTime()
        }
        .onChange(of: selectedTime) { _ in
            updateFieldsForSelectedTime()
        }
    }
    
    private func updateFieldsForSelectedTime() {
        if let times = timeManager.meetingTimes[selectedTime] {
            let components = times.startTime.split(separator: ":").map(String.init)
            if components.count == 2 {
                startHour = components[0]
                startMinute = components[1]
            }
            
            let endComponents = times.endTime.split(separator: ":").map(String.init)
            if endComponents.count == 2 {
                endHour = endComponents[0]
                endMinute = endComponents[1]
            }
        } else {
            startHour = ""
            startMinute = ""
            endHour = ""
            endMinute = ""
        }
    }
}

struct TimeInputView: View {
    @Binding var hour: String
    @Binding var minute: String

    var body: some View {
        HStack {
            TextField("HH", text: $hour)
                .frame(width: 60, height: 44)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .font(.system(size: 16, weight: .bold))
                .padding(.trailing, 5)

            TextField("MM", text: $minute)
                .frame(width: 60, height: 44)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .font(.system(size: 16, weight: .bold))
        }
        .padding(.bottom, 20)
    }
}

enum TimeOption: String, CaseIterable {
    case coffeeChat = "Coffee Chat"
    case lunchBreak = "Lunch Break"
    case dinnerMeetup = "Dinner Meetup"
}


#Preview {
    TimePreferencesView()
        .environmentObject(TimeManager())
}
