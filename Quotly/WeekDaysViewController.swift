//
//  WeekDaysViewController.swift
//  Quotly
//
//  Created by Saverio Negro on 14/12/24.
//

import SwiftUI

@Observable
class WeekDaysViewController {
    private var weekdays: [WeekDay] = [WeekDay]()
    
    func getWeekDays() -> [WeekDay] {
        return self.weekdays
    }
}
