//
//  OnboardingButtonView.swift
//  Quotly
//
//  Created by Saverio Negro on 14/02/25.
//

import SwiftUI

struct OnboardingButtonView: View {
    
    let onPress: () -> Void
    
    var body: some View {
        Button {
            onPress()
        } label: {
            Text("Start Inspiring Yourself")
                .font(.title3)
                .foregroundStyle(.white)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 50)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.darkBlue)
        )
        .foregroundStyle(.lightBlue)

    }
}

#Preview {
    OnboardingButtonView(onPress: { print("Button Pressed.") })
}
