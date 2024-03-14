import SwiftUI

struct CalendarView: View {
    @State private var currentDate = Date()
    
    private var daysOfWeek: [String] {
        ["", "Mon", "Tue", "Wed", "Thu", "Fri"]
    }
    
    private var gridItems: [GridItem] {
        [GridItem(.fixed(50))] + Array(repeating: .init(.flexible()), count: 5)
    }
    
    private var timeSlots: [String] {
        let startHour = 8 // 8 AM
        let endHour = 20 // 8 PM
        return (startHour...endHour).map { hour -> String in
            let isPM = hour >= 12
            let adjustedHour = hour > 12 ? hour - 12 : hour
            return "\(adjustedHour)\(isPM ? "PM" : "AM")"
        }
    }
    
    var body: some View {
        VStack {
            weekNavigation
            daysOfWeekHeader
            ScrollView {
                timeSlotsGrid
            }
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
    
    private var timeSlotsGrid: some View {
        ForEach(timeSlots, id: \.self) { timeSlot in
            LazyVGrid(columns: gridItems, spacing: 20) {
                Text(timeSlot)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .frame(height: 60)
                
                ForEach(1..<6) { _ in // Adjusted to 5 for weekdays only
                    Text("")
                        .frame(height: 60)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(5)
                }
            }
        }
    }
    
    private func changeWeek(by weeks: Int) {
        if let weekOffset = Calendar.current.date(byAdding: .weekOfYear, value: weeks, to: currentDate) {
            currentDate = weekOffset
        }
    }
    
    private var currentWeekRange: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        
        guard let startOfWeek = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate)),
              let endOfWeek = Calendar.current.date(byAdding: .day, value: 4, to: startOfWeek) else {
            return ""
        }
        return "\(formatter.string(from: startOfWeek)) - \(formatter.string(from: endOfWeek))"
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
