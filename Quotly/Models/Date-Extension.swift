//
//  Date-Extension.swift
//  Quotly
//
//  Created by Saverio Negro on 14/12/24.
//

import Foundation

extension Date {
    
    enum DayTime: CaseIterable {
        case morning
        case afternoon
        case evening
    }
    
    func getMemoDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        return formatter.string(from: self)
    }
    
    func getMemoDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "eeee"
        return formatter.string(from: self)
    }
    
    nonisolated(unsafe) static var selectedWeekDay: Int = Date.currentWeekDayIndex
    
    static var morningDate: Date {
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour], from: Date.now)
        components.hour = 0
        return Calendar.current.date(from: components)!    }
    
    static var afternoonDate: Date {
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour], from: Date.now)
        components.hour = 12
        return Calendar.current.date(from: components)!
    }

    static var eveningDate: Date {
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour], from: Date.now)
        components.hour = 17
        return Calendar.current.date(from: components)!
    }
    
    static func isToday(_ date: Date) -> Bool {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: Date.now)
        let todayDate = Calendar.current.date(from: components)!
        
        components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let modifiedDate = Calendar.current.date(from: components)!
        
        return todayDate == modifiedDate
    }
    
    static func isFromPastDays(_ date: Date) -> Bool {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: Date.now)
        let todayDate = Calendar.current.date(from: components)!
        
        components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let modifiedDate = Calendar.current.date(from: components)!
        
        return todayDate > modifiedDate
    }
    
    static var hasHitMorning: Bool {
        return Date.now >= morningDate
    }
    
    static var hasHitAfternoon: Bool {
        return Date.now >= afternoonDate
    }
    
    static var hasHitEvening: Bool {
        return Date.now >= eveningDate
    }
    
    static func getCurrentDayTime() -> DayTime {
        if hasHitEvening {
            return .evening
        } else if hasHitAfternoon {
            return .afternoon
        } else {
            return .morning
        }
    }
    
    static func getStringDayTime(dayTime: DayTime) -> String {
        switch dayTime {
        case .morning:
            return "Morning"
        case .afternoon:
            return "Afternoon"
        case .evening:
            return "Evening"
        }
    }
    
    static func getSymbol(dayTime: DayTime) -> String {
        switch dayTime {
        case .morning:
            return "sunrise.fill"
        case .afternoon:
            return "sun.max.fill"
        case .evening:
            return "moon.fill"
        }
    }
    
    static var weekdays: [String] {
        return ["Sun", "Mon", "Tue", "Wed", "Thur", "Fri", "Sat"]
    }
    
    static var secondsInADay: Int {
        return 24 * 3600
    }
    
    static var currentWeekDayIndex: Int {
        let date = Date.now
        let components = Calendar.current.dateComponents([.weekday, .weekdayOrdinal], from: date)
        let weekday = components.weekday!
        let index = weekday - 1
        return index
    }
    
    static func getWeekDay(_ index: Int) -> Int {
        let gap = currentWeekDayIndex - index
        let weekDayDate = self.now - (Double(gap * secondsInADay))
        let components = Calendar.current.dateComponents([.day], from: weekDayDate)
        return components.day!
    }
    
    static func getWeekDayDate(_ index: Int) -> Date {
        let gap = currentWeekDayIndex - index
        let weekDayDate = self.now - (Double(gap * secondsInADay))
        return weekDayDate
    }
    
    static func getCurrentWeekDay() -> Int {
        return getWeekDay(currentWeekDayIndex)
    }
    
    static func isPastCurrentWeekDay(_ index: Int) -> Bool {
        return getWeekDay(index) > getCurrentWeekDay()
    }
    
    static func getMonthAndDay(_ index: Int) -> String {
        let gap = currentWeekDayIndex - index
        let weekDayDate = self.now - (Double(gap * secondsInADay))
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd"
        return formatter.string(from: weekDayDate)
    }
    
    static func getTime(for dayTime: String) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        switch dayTime {
        case "morning":
            return formatter.string(from: morningDate)
        case "afternoon":
            return formatter.string(from: afternoonDate)
        default:
            return formatter.string(from: eveningDate)
        }
    }
    
    static func convertDateToString(_ date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
