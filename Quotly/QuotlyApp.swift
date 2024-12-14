//
//  QuotlyApp.swift
//  Quotly
//
//  Created by Saverio Negro on 13/12/24.
//

import SwiftUI

@main
struct QuotlyApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                Tab("Home", systemImage: "house") {
                    ContentView()
                }
                
                Tab("Entries", systemImage: "book.pages") {
                    
                }
                
                Tab("Profile", systemImage: "person") {
                    
                }
            }
        }
    }
}
