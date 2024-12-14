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
    
    init(quote: Quote, memo: Memo) {
        self.quote = quote
        self.memo = memo
    }
}
