//
//  Memo.swift
//  Quotly
//
//  Created by Saverio Negro on 14/12/24.
//

import SwiftUI

enum DayTime {
    case morning
    case afternoon
    case evening
}

struct Memo {
    
    let name: String
    var text = [
        "morning": "",
        "afternoon": "",
        "evening": ""
    ]
    
    func getDayTime(dayTime: DayTime) -> String {
        switch dayTime {
        case .morning:
            return "morning"
        case .afternoon:
            return "afternoon"
        case .evening:
            return "evening"
        }
    }
    
    mutating func insertText(for dayTime: DayTime, text: String) {
        let dayTime = getDayTime(dayTime: dayTime)
        
        self.text[dayTime] = text
    }
}
