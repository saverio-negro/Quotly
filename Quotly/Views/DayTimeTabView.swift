//
//  DayTimeTabView.swift
//  Quotly
//
//  Created by Saverio Negro on 17/12/24.
//

import SwiftUI

struct DayTimeTabView: View {
    
    let text: String
    let dayTime: Date.DayTime
    var doesEntryExist: Bool
    @Binding var selectedDayTime: String
    
    
    var body: some View {
        Button {
            selectedDayTime = text
        } label: {
            Text(text)
                .font(.title3)
        }
        .frame(maxWidth: 200, maxHeight: 150)
        .clipShape(.rect(cornerRadius: 10))
        .buttonStyle(.plain)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.lightBlue)
            VStack {
                HStack {
                    Image(systemName: Date.getSymbol(dayTime: dayTime))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    Spacer()
                }
                Spacer()
                HStack {
                    Spacer()
                    Image(systemName: doesEntryExist ? "checkmark.circle.fill" : "checkmark.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                }
            }
            .padding(10)
        }
    }
}

#Preview {
    DayTimeTabView(text: "Morning", dayTime: .morning, doesEntryExist: false, selectedDayTime: .constant("Morning"))
        .preferredColorScheme(.dark)
}
