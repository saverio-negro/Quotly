//
//  DayTimeTabsView.swift
//  Quotly
//
//  Created by Saverio Negro on 17/12/24.
//

import SwiftUI

struct DayTimeTabsView: View {
    
    let memo: Memo?
    
    @Binding var selectedDayTime: String
    @Binding var selectedWeekDay: Int
    
    var date: Date {
        return Date.getWeekDayDate(selectedWeekDay)
    }
    
    func doesEntryExist(for dayTime: Date.DayTime) -> Bool {
        
        let dayTimeString = Date.getStringDayTime(dayTime: dayTime).lowercased()
        
        if let unwrappedMemo = memo {
            return unwrappedMemo.doesEntryExist(for: dayTimeString)
        } else {
            return false
        }
    }
    
    var body: some View {

        HStack {
            // Card relative to the morning memo
            DayTimeTabView(
                text: "Morning",
                dayTime: .morning,
                doesEntryExist: doesEntryExist(for: .morning),
                selectedDayTime: $selectedDayTime
            )
                .background(selectedDayTime == "Morning" ? .aquamarine : .darkBlue)
                .clipShape(.rect(cornerRadius: 10))
                .disabled(Date.isToday(date) ? (!Date.hasHitMorning) : !Date.isFromPastDays(date))
            
            // Card relative to the afternoon memo
            DayTimeTabView(
                text: "Afternoon",
                dayTime: .afternoon,
                doesEntryExist: doesEntryExist(for: .afternoon),
                selectedDayTime: $selectedDayTime
            )
                .background(selectedDayTime == "Afternoon" ? .aquamarine : .darkBlue)
                .clipShape(.rect(cornerRadius: 10))
                .disabled(Date.isToday(date) ? (!Date.hasHitAfternoon) : !Date.isFromPastDays(date))
            
            // Card relative to the evening memo
            DayTimeTabView(
                text: "Evening",
                dayTime: .evening,
                doesEntryExist: doesEntryExist(for: .evening),
                selectedDayTime: $selectedDayTime
            )
                .background(selectedDayTime == "Evening" ? .aquamarine : .darkBlue)
                .clipShape(.rect(cornerRadius: 10))
                .disabled(Date.isToday(date) ? (!Date.hasHitEvening) : !Date.isFromPastDays(date))
        }
    }
}

#Preview {
    DayTimeTabsView(memo: Memo(date: Date.now), selectedDayTime: .constant("Morning"), selectedWeekDay: .constant(Date.currentWeekDayIndex))
        .preferredColorScheme(.dark)
}
