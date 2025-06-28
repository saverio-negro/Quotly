//
//  DayTimeButtonView.swift
//  Memos
//
//  Created by Saverio Negro on 25/01/25.
//

import SwiftUI

struct DayTimeButtonView: View {
    
    let action: () -> Void
    let label: () -> Text
    
    var body: some View {
        Button {
            action()
        } label: {
            label()
        }
        .padding()
        .frame(minWidth: 120)
        .foregroundStyle(.white)
    }
}

#Preview {
    DayTimeButtonView(action: { print("Tapped!") }, label: { Text("Tap Me") })
}
