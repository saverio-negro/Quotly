//
//  WeekDay.swift
//  Quotly
//
//  Created by Saverio Negro on 14/12/24.
//

import SwiftUI

@Observable
class WeekDay {
    var quote: Quote
    let date: Date
    
    init(quote: Quote, date: Date) {
        self.quote = quote
        self.date = date
    }
}
