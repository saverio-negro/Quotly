//
//  WeekDayView.swift
//  Quotly
//
//  Created by Saverio Negro on 14/12/24.
//

import SwiftUI

struct WeekDayView: View {

    let weekDay: String
    let weekDayDate: Int
    let index: Int
    
    var body: some View {
        VStack {
            VStack {
                Text("\(weekDay)")
                    .bold(index == WeekDay.currentWeekDayIndex)
                
            }
            .padding(.top, 10)
            .padding(.bottom, 5)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.aquamarine)
            
            VStack {
                Text("\(weekDayDate)")
                    .bold(index == WeekDay.currentWeekDayIndex)
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

#Preview {
    WeekDayView(weekDay: "Mon", weekDayDate: 5, index: 0)
}
