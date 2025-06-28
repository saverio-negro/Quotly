//
//  WeekView.swift
//  Quotly
//
//  Created by Saverio Negro on 14/12/24.
//

import SwiftUI

struct WeekDaysView: View {
    
    @Environment(WeekDaysViewModel.self) var weekDaysViewController
    @Binding var selectedWeekDay: Int
    @State var position = ScrollPosition(idType: Int.self)
    
    let rows = [
        GridItem(.flexible(minimum: 50))
    ]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 0) {
                ForEach(Date.weekdays.indices, id: \.self) { index in
                    
                    Button {
                        withAnimation(
                            Animation.spring(duration: 0.05, bounce: 0.6)
                        ) {
                            selectedWeekDay = index
                        }
                    } label: {
                        WeekDayView(
                            weekDay: Date.weekdays[index],
                            weekDayDate: Date.getWeekDay(index),
                            index: index
                        )
                        .opacity(selectedWeekDay == index ? 1: 0.8)
                        .scaleEffect(selectedWeekDay == index ? 1 : 0.8)
                    }
                    .buttonStyle(.plain)
                    .disabled(Date.isPastCurrentWeekDay(index))
                    .scrollTransition(ScrollTransitionConfiguration.animated.threshold(.visible(0.35))) { content, phase in
                        content
                            .scaleEffect(phase.isIdentity ? 1 : 0.75)
                            .blur(radius: phase.isIdentity ? 0 : 0.5)
                            .opacity(phase.isIdentity ? 1: 0.8)
                    }
                }
            }
        }
        .scrollClipDisabled()
        .scrollIndicators(.hidden)
        .scrollPosition($position, anchor: .center)
        .frame(maxHeight: 110)
        .onAppear {
            position.scrollTo(id: selectedWeekDay, anchor: .center)
        }
    }
}

#Preview {
    WeekDaysView(selectedWeekDay: .constant(Date.currentWeekDayIndex))
        .preferredColorScheme(.dark)
        .environment(WeekDaysViewModel())
}
