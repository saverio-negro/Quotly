//
//  WeekView.swift
//  Quotly
//
//  Created by Saverio Negro on 14/12/24.
//

import SwiftUI

struct WeekDaysView: View {
    
    let weekdays = ["Sun", "Mon", "Tue", "Wed", "Thur", "Fri", "Sat"]
    var secondsInADay = 24 * 60 * 60
    func getWeekDay(weekDayIndex: Int) -> Int {
        let gap = WeekDay.currentWeekDayIndex - weekDayIndex
        let weekDayDate = Date.now - (Double(gap * secondsInADay))
        let components = Calendar.current.dateComponents([.day], from: weekDayDate)
        return components.day!
    }
    
    let rows = [
        GridItem(.flexible(minimum: 50, maximum: 100))
    ]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows) {
                ForEach(weekdays.indices, id: \.self) { index in
                    WeekDayView(
                        weekDay: weekdays[index],
                        weekDayDate: getWeekDay(weekDayIndex: index),
                        index: index
                    )
                }
            }
        }
    }
}

#Preview {
    WeekDaysView()
        .preferredColorScheme(.dark)
}
