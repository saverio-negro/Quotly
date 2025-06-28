//
//  WeekDaysViewModels.swift
//  Quotly
//
//  Created by Saverio Negro on 14/12/24.
//

import SwiftUI

@Observable
class WeekDaysViewModel {
    
    private var weekdays = [WeekDay]()
    private let quotes: [String : Quote] = Bundle.main.decode("quotes.json")
    
    init(weekdays: [WeekDay] = [WeekDay]()) {
        for index in 0..<Date.weekdays.count {
            let monthAndDay = Date.getMonthAndDay(index)
            if let quote = quotes[monthAndDay] {
                let weekDay = WeekDay(quote: quote, date: Date.getWeekDayDate(index))
                self.weekdays.append(weekDay)
            }
        }
    }
    
    func getWeekDays() -> [WeekDay] {
        return self.weekdays
    }
    
    func getQuote(for weekDayIndex: Int) -> Quote {
        self.weekdays[weekDayIndex].quote
    }
    
    func setQuote(for weekDayIndex: Int, quote: Quote) {
        self.weekdays[weekDayIndex].quote = quote
    }
}
