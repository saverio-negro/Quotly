//
//  ContentView.swift
//  Quotly
//
//  Created by Saverio Negro on 13/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.darkBackground
                VStack {
                    WeekDaysView()
                }
                .padding(.horizontal)
            }
            .ignoresSafeArea()
            
            VStack {
                
            }
            .navigationTitle("Quotly")
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}
