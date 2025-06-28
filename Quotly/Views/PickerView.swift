//
//  PickerView.swift
//  Memos
//
//  Created by Saverio Negro on 25/01/25.
//

import SwiftUI

struct PickerView<T: Hashable>: View {
    
    let text: String
    @Binding var selection: T
    let content: () -> ForEach<Array<T>, T, Text>
    
    var body: some View {
        
        let data = content().data
        let content = content().content
        
        HStack {
            ForEach(data, id: \.self) { item in
                
                DayTimeButtonView {
                    
                    selection = item
                    
                } label: {
                    content(item)
                }
                .background(selection == item ? Color.aquamarine : Color.darkBlue)
                .animation(Animation.spring(duration: 0.5, bounce: 0), value: selection)
                .clipShape(.capsule)
                .animation(nil, value: selection)
                .scaleEffect(selection == item ? 1 : 0.9)
                .animation(Animation.spring(duration: 0.3, bounce: 0.6), value: selection)
                
            }
        }
    }
}

#Preview {
    
    let dayTimes = ["morning", "afternoon", "evening"]
    
    PickerView(text: "Day Time", selection: .constant("morning")) {
        ForEach(dayTimes, id: \.self) { dayTime in
            Text("\(dayTime.capitalized)")
        }
    }
}
