//
//  FilterMemosView.swift
//  Quotly
//
//  Created by Saverio Negro on 11/02/25.
//

import SwiftData
import SwiftUI

struct FilterMemosView: View {
    
    @Query(sort: [
        SortDescriptor(\Memo.date)
    ]) var memos: [Memo]
    
    @Environment(\.modelContext) var modelContext
    
    init() {
        let memoDate = Date.getWeekDayDate(Date.selectedWeekDay)
        let currentMemoDateString = Date.convertDateToString(memoDate, format: "MM-dd-yyyy")
        
        if !memos.isEmpty {
            _memos = Query(
                filter: #Predicate<Memo> { memo in
                    return currentMemoDateString == memo.memoDateString
                },
                sort: [SortDescriptor(\Memo.date)]
            )
        }
    }
    
    var body: some View {
        EmptyView()
    }
    
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Memo.self, configurations: config)
    
    FilterMemosView()
        .modelContainer(container)
}
