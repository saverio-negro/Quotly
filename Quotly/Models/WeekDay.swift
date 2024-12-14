//
//  WeekDay.swift
//  Quotly
//
//  Created by Saverio Negro on 14/12/24.
//

import SwiftUI

@Observable
class WeekDay {
    
    let quote: Quote
    var memo: Memo
    static var currentWeekDayIndex: Int {
        let date = Date.now
        let components = Calendar.current.dateComponents([.weekday, .weekdayOrdinal], from: date)
        let weekday = components.weekday!
        let index = weekday - 1
        return index
    }
    
    init(quote: Quote, memo: Memo) {
        self.quote = quote
        self.memo = memo
    }
}
