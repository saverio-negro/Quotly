//
//  Date-Calendar-Extension.swift
//  CustomCalendar
//
//  Created by Saverio Negro on 17/02/25.
//

import Foundation

extension Date {
    
    // Get localized first letters of weekdays
    static var capitalizedFirstLettersOfWeekdays: [String] {
        let calendar = Calendar.current
        // Get a list of shorter-named weekdays in the calendar
        // localized to the `Calendar`'s locale.
        let weekdays = calendar.shortWeekdaySymbols
        
        return weekdays.map { weekday in
            guard let firstLetter = weekday.first else { return "" }
            return String(firstLetter).capitalized
        }
    }
    
    // Get first weekday of the month
    var firstDayOfMonthIndex: Int {
        
        let calendar = Calendar.current
        var components = calendar.dateComponents([.day, .month, .year], from: self)
        components.day = 1
        
        guard let firstDayOfMonth = calendar.date(from: components) else { return -1 }
        
        let weekDayIndex = calendar.dateComponents([.weekday], from: firstDayOfMonth).weekday!
        
        return weekDayIndex - 1
    }
    
    // Check whether the year is a leap year
    var isLeapYear: Bool {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
    }
    
    // Get current month
    var currentMonth: String {
        let calendar = Calendar.current
        let months = calendar.monthSymbols
        
        guard let currentMonthIndex = calendar.dateComponents([.month], from: self).month else { return "" }
        return months[currentMonthIndex - 1]
    }
    
    // Get number of days in month
    var numberOfDays: Int {
        switch currentMonth {
        case "January":
            31
        case "February":
            isLeapYear ? 29 : 28
        case "March":
            31
        case "April":
            30
        case "May":
            31
        case "June":
            30
        case "July":
            31
        case "August":
            31
        case "September":
            30
        case "October":
            31
        case "November":
            30
        default:
            31
        }
    }
    
    // Get first excluded weekdays in the month
    var excludedWeekDays: [String] {
        
        let calendar = Calendar.current
        let weekdays = calendar.weekdaySymbols
        
        return weekdays.indices.compactMap { index in
            if index < self.firstDayOfMonthIndex {
                return weekdays[index]
            }
            return nil
        }
    }
    
    // Get date from day of the month
    func getDate(for day: Int) -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.day, .month, .year], from: self)
        components.day = day
        
        guard let newDate = calendar.date(from: components) else { return .now }
        return newDate
    }
    
    // Get day from date
    var getDayIndex: Int {
        let calendar = Calendar.current
        let componenets = calendar.dateComponents([.day], from: self)
        
        guard let day = componenets.day else { return -1 }
        return day
    }
}
