//
//  Memo.swift
//  Quotly
//
//  Created by Saverio Negro on 14/12/24.
//

import SwiftData
import SwiftUI

@Model
class Memo {
    
    var date: Date
    var dayTime = "morning"
    var quote: Quote?
    var entries = [
        "morning": [
            "title": "",
            "text": "",
            "sentimentScore": "0",
            "isEmpty": "true"
        ],
        "afternoon": [
            "title": "",
            "text": "",
            "sentimentScore": "0",
            "isEmpty": "true"
        ],
        "evening": [
            "title": "",
            "text": "",
            "sentimentScore": "0",
            "isEmpty": "true"
        ]
    ]
    var memoDateString: String {
        return Date.convertDateToString(date, format: "MM-dd-yyyy")
    }
    var isEmpty: Bool {
        
        for dayTime in entries.keys {
            
            let isEntryEmpty = entries[dayTime]!["isEmpty"]!
            
            if isEntryEmpty == "false" {
                return false
            }
        }
        
        return true
    }
    var memoTitle: String {
        
        get {
            return entries[dayTime]!["title"]!
        }
        
        set {
            entries[dayTime]!["title"] = newValue
        }
    }
    var memoText: String {
        
        get {
            return entries[dayTime]!["text"]!
        }
        
        set {
            entries[dayTime]!["text"] = newValue
        }
    }
    var sentimentScore: Double {
        get {
            return entries[dayTime]!["sentimentScore"]! == "Other" ? 0 : Double(entries[dayTime]!["sentimentScore"]!)!
        }
        
        set {
            entries[dayTime]!["sentimentScore"]! = String(newValue)
        }
    }
    var averageSentimentScore: Double {
        
        var totalScore = 0.0
        
        for dayTime in entries.keys {
            totalScore += Double(entries[dayTime]!["sentimentScore"]!)!
        }
        
        return totalScore / 3
    }
    var heartNumber: Int {
        
        switch sentimentScore {
            case -1.0 ..< -0.5:
                return 1
            case -0.5..<0:
                return 2
            case 0..<0.5:
                return 3
            case 0.5..<1.0:
                return 4
            default:
                return 5
        }
    }
    
    func highlightFilledDayTimeSymbols() -> HStack<some View> {

        return HStack {
            ForEach(Date.DayTime.allCases, id: \.self) { dayTime in
                let dayTimeString = Date.getStringDayTime(dayTime: dayTime).lowercased()
                let dayTimeSymbol = Image(systemName: Date.getSymbol(dayTime: dayTime))
               
                if self.doesEntryExist(for: dayTimeString) {
                    dayTimeSymbol.font(.title2)
                } else {
                    dayTimeSymbol.font(.title3).opacity(0.4)
                }
            }
        }
    }
    
    func getFilledDaySymbols() -> HStack<some View> {
        return HStack(spacing: 0) {
            ForEach(Date.DayTime.allCases, id: \.self) { dayTime in
                let dayTimeString = Date.getStringDayTime(dayTime: dayTime).lowercased()
                let dayTimeSymbol = Image(systemName: Date.getSymbol(dayTime: dayTime))
                
                if self.doesEntryExist(for: dayTimeString) {
                    dayTimeSymbol
                        .font(.custom("dayTimeCalendarSymbol", fixedSize: 9))
                }
            }
        }
    }
    
    func doesEntryExist(for dayTime: String) -> Bool {
        return entries[dayTime]!["isEmpty"]! == "false"
    }
    
    func setIsEmpty(value: String) {
        entries[dayTime]!["isEmpty"] = value
    }
    
    func shouldBeDeleted() -> Bool {
        let title = entries[dayTime]!["title"]!
        let text = entries[dayTime]!["text"]!
        
        return title == "" && text == ""
    }
    
    func hasHit(_ dayTime: String) -> Bool {
        switch dayTime {
        case "morning":
            return Date.hasHitMorning
        case "afternoon":
            return Date.hasHitAfternoon
        default:
            return Date.hasHitEvening
        }
    }
    
    func getWaitMessage(for dayTime: String) -> String {
        let time = Date.getTime(for: dayTime)
        return "Please, wait until \(time)."
    }
    
    init(date: Date, quote: Quote? = nil) {
        self.date = date
        self.quote = quote
    }
}
