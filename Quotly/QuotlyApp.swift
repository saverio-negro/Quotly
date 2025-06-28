//
//  QuotlyApp.swift
//  Quotly
//
//  Created by Saverio Negro on 13/12/24.
//

import SwiftData
import SwiftUI
import TipKit

@main
struct QuotlyApp: App {
    
    let weekDaysViewModel = WeekDaysViewModel()
    let memosViewModel = MemosViewModel()
    @AppStorage("isOnboarding") var isOnboarding = true
    
    var body: some Scene {
        WindowGroup {
            TabView {
                Tab("Quotes", systemImage: "quote.bubble.rtl") {
                    ContentView()
                        .environment(weekDaysViewModel)
                        .environment(memosViewModel)
                }
                
                Tab("Memos", systemImage: "book.pages") {
                    MemosView()
                        .environment(memosViewModel)
                }
            }
            .fullScreenCover(isPresented: $isOnboarding) {
                // Load and configure the persistent state of all tips in the app.
                try? Tips.configure()
            } content: {
                OnboardingTabView()
            }
            .tabBarBackgroundColor(.darkBackground)
        }
        .modelContainer(for: Memo.self)
    }
    
    init() {
        
        // Load and configure the persistent state of all tips in the app.
        if !isOnboarding {
            try? Tips.configure()
        }
    }
}
