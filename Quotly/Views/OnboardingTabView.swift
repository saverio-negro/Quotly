//
//  OnboardingTabView.swift
//  Quotly
//
//  Created by Saverio Negro on 14/02/25.
//

import SwiftUI

struct OnboardingTabView: View {
    
    var body: some View {
        TabView {
            OnboardingView()
        }
        .ignoresSafeArea()
        .tabViewStyle(.page)
    }
}

#Preview {
    OnboardingTabView()
}
