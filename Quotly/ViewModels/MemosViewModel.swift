//
//  MemosViewModel.swift
//  Quotly
//
//  Created by Saverio Negro on 12/02/25.
//

import SwiftData
import SwiftUI

@Observable
class MemosViewModel {
    
    var backupMemos: [Memo] = [Memo]()
    var memos: [Memo] = [Memo]()
    var isFilterDateApplied = false
    var isFilterTextApplied = false
    
    func findMemo(by date: String) -> Memo? {
        for memo in memos {
            if memo.memoDateString == date {
                return memo
            }
        }
        return nil
    }
    
    func filterMemoDate(by date: Date) {
        
        if !isFilterDateApplied && !isFilterTextApplied {
            memos = backupMemos
        } else if isFilterDateApplied {
            
            var components = Calendar.current.dateComponents([.day, .month, .year], from: date)
            components.year = Calendar.current.dateComponents([.year], from: .now).year!
            let date = Calendar.current.date(from: components)
            let dateString = Date.convertDateToString(date!, format: "MM-dd-yyyy")
            
            memos = memos.filter { memo in memo.memoDateString == dateString }
        }
    }
    
    func filterMemoText(by text: String) {
        
        if !isFilterDateApplied && !isFilterTextApplied {
            memos = backupMemos
        } else if isFilterTextApplied {
            memos = memos.filter { memo in
                
                let isIncludedInMemoTitle = memo.memoTitle.localizedCaseInsensitiveContains(text)
                let isIncludedInMemoText = memo.memoText.localizedCaseInsensitiveContains(text)
                
                return isIncludedInMemoTitle || isIncludedInMemoText
            }
        }
    }
    
    func getMemo(by date: Date) -> Memo? {
        
        let dateString = Date.convertDateToString(date, format: "MM-dd-yyyy")
        
        let filteredMemos = backupMemos.filter { memo in
            return memo.memoDateString == dateString
        }
        
        return filteredMemos.first ?? nil
    }
}
