//
//  ContentView.swift
//  Quotly
//
//  Created by Saverio Negro on 13/12/24.
//

import SwiftData
import SwiftUI
import TipKit

struct ContentView: View {
    
    @Query(sort: \Memo.date, order: .reverse) var memos: [Memo]
    
    @Environment(\.modelContext) var modelContext
    @Environment(WeekDaysViewModel.self) var weekDaysViewModel
    @Environment(MemosViewModel.self) var memosViewModel
    
    @State private var selectedWeekDay = Date.currentWeekDayIndex
    var quote: Quote {
        return weekDaysViewModel.getQuote(for: selectedWeekDay)
    }
    @State private var selectedDayTime = Date.getStringDayTime(dayTime: Date.getCurrentDayTime())
    @State var isCoverPresented = false
    @State var isMemoViewPresented = false
    
    var currentMemoDateString: String {
        let memoDate = Date.getWeekDayDate(selectedWeekDay)
        return Date.convertDateToString(memoDate, format: "MM-dd-yyyy")
    }
    
    var doesMemoExist: Bool {
        return memos.count == 1
    }
    
    var memo: Memo? {
        memosViewModel.findMemo(by: currentMemoDateString)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.darkBackground
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        WeekDaysView(selectedWeekDay: $selectedWeekDay)
                        VStack {
                            QuoteCardView(
                                memo: memo ?? nil,
                                author: quote.author,
                                text: quote.text,
                                selectedWeekDay: $selectedWeekDay
                            )
                            DayTimeTabsView(memo: memo, selectedDayTime: $selectedDayTime, selectedWeekDay: $selectedWeekDay)
                        }
                        .padding(.bottom, 20)
                        Button {
                            
                            let dayTime = selectedDayTime.lowercased()
                            
                            if let memo = self.memo {
                                if memo.doesEntryExist(for: dayTime) {
                                    // Present `MemoView`
                                    isMemoViewPresented = true
                                } else {
                                    // Present `AddMemoView`
                                    isCoverPresented = true
                                }
                            } else {
                                // Present `AddMemoView`
                                isCoverPresented = true
                            }
                            
                        } label: {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                        }
                        .padding(30)
                        .background(.aquamarine)
                        .clipShape(.circle)
                        .buttonStyle(.plain)
                        .overlay {
                            Circle()
                                .stroke(.lightBlue)
                        }
                        .fullScreenCover(isPresented: $isCoverPresented) {
                            
                            if let memo = self.memo {
                                return AddMemoView(memo: memo, selectedDayTime: $selectedDayTime)
                            } else {
                                let memoDate = Date.getWeekDayDate(selectedWeekDay)
                                let newMemo = Memo(date: memoDate, quote: quote)
                                return AddMemoView(memo: newMemo, selectedDayTime: $selectedDayTime)
                            }
                        }
                        .fullScreenCover(isPresented: $isMemoViewPresented) {
                            MemoView(memo: memo!)
                        }
                    }
                    .padding(.horizontal)
                    Spacer()
                    Spacer()
                }
            }
            .onChange(of: memos, { oldValue, newValue in
                memosViewModel.memos = newValue
            })
            .onAppear {
                
//                try! modelContext.delete(model: Memo.self)
                
                if let unwrappeedMemo = self.memo {
                    unwrappeedMemo.dayTime = selectedDayTime.lowercased()
                }
                
                memosViewModel.memos = memos
            }
            .navigationTitle("Quotes")
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        UserDefaults().set(true, forKey: "isOnboarding")
                    } label: {
                        Label("Back to Onboarding", systemImage: "questionmark.circle")
                    }
                }
            }
        }
        .navigationBarBackgroundColor(.darkBackground)
    }
}

#Preview {
    
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Memo.self, configurations: config)
    
    ContentView()
        .modelContainer(container)
        .environment(WeekDaysViewModel())
        .environment(MemosViewModel())
}

// List of To-dos and Touch-ups:

// 1. Grant title modification for memos. (done) ✓

// 2. User can tap anywhere on memo preview to get to the memo. (pondering) ❔

// 3. Implement sentiment analysis on the memo view. (done) ✓

// 4. Connect main view to memos view. (important) 3 days (done) ✓

// 5. Connect the daily quote to the `MemoView`. (important) 1 day (done) ✓

// 6. Implement filter for memos by date and title/text. (important) 1 day (done) ✓

// 7. Keep the user from adding a memo for a daytime yet to come. (done) 1 day ✓

// 8. Adjust the UI for `MemoCardView`, make the height of the card responsive
//    (try using `GeometryReader`) and increase the minimum height. (nice to have). (done) ✓

// 9. Send user to memo view right after they create a new one. (important) 1 day (done)

// 10. Move the "Remove Date Filter" button to `CalendarView`. (in progress) 1 day

// 11. Implement a "quote-image-upload" option to give users a one-time
//    possibility to change their current daily quote with their preferred one. (nice to    have) 3 days (in progress...)

// 12. Allow users to copy the text of the daily quote by holding down the
//     card. (nice to have) 1 day

// 13. Improve accessibility. (nice to have) 2 day

