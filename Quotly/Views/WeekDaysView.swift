//
//  WeekView.swift
//  Quotly
//
//  Created by Saverio Negro on 14/12/24.
//

import SwiftUI

struct WeekDaysView: View {
    
    let weekdays = ["Sun", "Mon", "Tue", "Wed", "Thur", "Fri", "Sat"]
    var currentWeekDay: Int {
        let date = Date.now
        let components = Calendar.current.dateComponents([.weekday, .weekdayOrdinal], from: date)
        let weekday = components.weekday!
        let index = weekday - 1
        return index
    }
    var secondsInADay = 24 * 60 * 60
    
    func getWeekDay(weekDayIndex: Int) -> Int {
        let gap = currentWeekDay - weekDayIndex
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
                    VStack {
                        VStack {
                            Text(weekdays[index])
                                .bold(index == currentWeekDay)
                            
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.aquamarine)
                        
                        VStack {
                            Text("\(getWeekDay(weekDayIndex: index))")
                                .bold(index == currentWeekDay)
                        }
                        .padding(.vertical, 10)
                    }
                    .frame(width: 90, height: 90)
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.lightBlue)
                    }
                }
            }
        }
    }
}

#Preview {
    WeekDaysView()
        .preferredColorScheme(.dark)
}
