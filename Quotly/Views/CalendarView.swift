//
//  CalendarView.swift
//  CustomCalendar
//
//  Created by Saverio Negro on 17/02/25.
//

import SwiftUI
import SwiftData

struct CalendarView: View {
    
    @Environment(MemosViewModel.self) var memosViewController
    @Binding var date: Date
    
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    var columns: [GridItem] {
        return daysOfWeek.map { _ in
            GridItem(.adaptive(minimum: 120), spacing: 20)
        }
    }
    
    var body: some View {
        
        let memo = memosViewController.getMemo(by: date)
        let vibesRatingBinding = Binding {
            return memo?.averageSentimentScore ?? -1.1
        } set: { _ in }

        
        ZStack {
            
            Color.darkBackground
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    
                    // Average Vibes Rating
                    VibesRatingView(vibesRating: vibesRatingBinding)
                    
                    // Date Picker
                    DatePicker("", selection: $date, in: ...Date.now, displayedComponents: .date)
                        .padding(.bottom, 20)
                        .blendMode(.colorDodge)
                        .foregroundStyle(.lightBlue)
                }
                
                // Calendar Header
                HStack(spacing: 20) {
                    ForEach(daysOfWeek.indices, id: \.self) { index in
                        let dayOfWeek = daysOfWeek[index]
                        Text("\(dayOfWeek)")
                            .fontWeight(.medium)
                            .font(.title2)
                            .foregroundStyle(.lightBlue)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.bottom, 10)
                
                LazyVGrid(columns: columns, spacing: 20) {
                    
                    ForEach(date.excludedWeekDays, id: \.self) { _ in
                        Text("")
                    }
                    
                    ForEach(1...date.numberOfDays, id: \.self) { index in
                        
                        let date = self.date.getDate(for: index)
                        let memo = memosViewController.getMemo(by: date)
                        
                        Button {
                            self.date = date
                        } label: {
                            VStack {
                                // Show day number
                                Text("\(index)")
                                    .foregroundStyle(.white)
                                
                                // Show only daytime symbols the user has an entry for
                                if let unwrappedMemo = memo {
                                    unwrappedMemo.getFilledDaySymbols()
                                }
                            }
                        }
                        .buttonStyle(.plain)
                        .frame(width: 52, height: 52)
                        .background(self.date.getDayIndex == index ?
                            (memo != nil ? .lightBlue : .aquamarine)
                                :
                            .darkBlue
                        )
                        .clipShape(.capsule)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    CalendarView(date: .constant(.now))
        .environment(MemosViewModel())
}
