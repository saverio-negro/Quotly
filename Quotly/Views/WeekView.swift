//
//  WeekView.swift
//  Quotly
//
//  Created by Saverio Negro on 14/12/24.
//

import SwiftUI

struct WeekView: View {
    
    let weekdays = ["Sun", "Mon", "Tue", "Wed", "Thur", "Fri", "Sat"]
    var currentWeekDay: Int {
        let date = Date.now
        let components = Calendar.current.dateComponents([.weekday, .weekdayOrdinal], from: date)
        let weekday = components.weekday!
        let index = weekday - 1
        return index
    }
    
    let rows = [
        GridItem(.flexible(minimum: 50, maximum: 100))
    ]
    
    var body: some View {
        
        LazyHGrid(rows: rows) {
            ForEach(weekdays.indices, id: \.self) { index in
                VStack {
                    Text(weekdays[index])
                        .bold(index == currentWeekDay)
                        .padding(.bottom, 5)
                    
                    Text("\(10)")
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(style: <#T##StrokeStyle#>)
                }
            }
        }
        .onAppear {
            let date = Date.now
            let components = Calendar.current.dateComponents([.weekday, .weekdayOrdinal], from: date)
            print(components.weekday!)
        }
    }
}

#Preview {
    WeekView()
}
