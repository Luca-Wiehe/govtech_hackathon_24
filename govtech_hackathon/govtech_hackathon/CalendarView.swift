import SwiftUI

struct Meeting {
    var title: String
    var start: Date
    var end: Date
}

struct CalendarView: View {
    @State private var currentDate = Date()
    private let calendar = Calendar.current
    
    // Define some sample meetings for the week of March 14, 2024
    private var meetings: [Meeting] = [
        Meeting(title: "Team Meeting", start: Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 14, hour: 9))!, end: Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 14, hour: 10))!),
        Meeting(title: "Project Review", start: Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 15, hour: 14))!, end: Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 15, hour: 15))!),
        Meeting(title: "One-on-One", start: Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 16, hour: 11))!, end: Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 16, hour: 12))!)
    ]
    
    private var daysOfWeek: [String] {
        ["", "Mon", "Tue", "Wed", "Thu", "Fri"]
    }
    
    private var gridItems: [GridItem] {
        [GridItem(.fixed(50))] + Array(repeating: .init(.flexible()), count: 5)
    }
    
    private var timeSlots: [String] {
        (8...20).map { hour -> String in
            "\(hour):00"
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.7), Color.red]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                weekNavigation
                daysOfWeekHeader.padding(.horizontal, 16)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        ForEach(0..<timeSlots.count, id: \.self) { index in
                            timeSlotRow(hourIndex: index)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                }
            }
            .background(Color.white)
            .cornerRadius(20)
            .padding(.horizontal, 32)
            .padding(.vertical, 64)
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
        }
    }
    
    private var weekNavigation: some View {
        HStack {
            Button(action: {
                self.changeWeek(by: -1)
            }) {
                Image(systemName: "chevron.left")
            }

            Spacer()
            
            Text(currentWeekRange)
                .font(.headline)

            Spacer()
            
            Button(action: {
                self.changeWeek(by: 1)
            }) {
                Image(systemName: "chevron.right")
            }
        }
        .padding()
    }
    
    private var daysOfWeekHeader: some View {
        LazyVGrid(columns: gridItems, spacing: 20) {
            ForEach(daysOfWeek, id: \.self) { day in
                Text(day)
                    .font(.headline)
            }
        }
        .padding(.bottom)
    }
    
    private func timeSlotRow(hourIndex: Int) -> some View {
        LazyVGrid(columns: gridItems, spacing: 20) {
            ForEach(0..<6, id: \.self) { column in
                if column == 0 {
                    Text(timeSlots[hourIndex])
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(height: 60)
                } else {
                    let dayOffset = column - 1
                    Rectangle()
                        .frame(height: 60)
                        .foregroundColor(isMeetingTime(slotHour: hourIndex + 8, dayOffset: dayOffset) ? Color.red.opacity(0.3) : Color.clear)
                        .border(Color.gray.opacity(0.3))
                }
            }
        }
    }
    
    private func isMeetingTime(slotHour: Int, dayOffset: Int) -> Bool {
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate)),
              let checkDate = calendar.date(byAdding: .day, value: dayOffset, to: startOfWeek),
              let slotStartDate = calendar.date(bySettingHour: slotHour, minute: 0, second: 0, of: checkDate) else {
            return false
        }

        for meeting in meetings {
            if slotStartDate >= meeting.start, slotStartDate < meeting.end {
                return true
            }
        }
        
        return false
    }
    
    private var currentWeekRange: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate)),
              let endOfWeek = calendar.date(byAdding: .day, value: 4, to: startOfWeek) else {
            return ""
        }
        return "\(formatter.string(from: startOfWeek)) - \(formatter.string(from: endOfWeek))"
    }
    
    private func changeWeek(by weeks: Int) {
        if let weekOffset = calendar.date(byAdding: .weekOfYear, value: weeks, to: currentDate) {
            currentDate = weekOffset
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
