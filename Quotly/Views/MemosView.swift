//
//  MemosView.swift
//  Memos
//
//  Created by Saverio Negro on 24/01/25.
//

import SwiftUI
import SwiftData

struct MemosView: View {
    
    @Environment(MemosViewModel.self) var memosViewController
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: [SortDescriptor(\Memo.date, order: .reverse)]) var memos: [Memo]
    
    let dayTimes = ["morning", "afternoon", "evening"]
    let filterByDateTip = FilterByDateTip()
    let filterByTextTip = FilterByTextTip()
    
    @State private var filterDate = Date.distantPast
    @State private var filterText = ""
    @State private var isSearchBarPresented = false
    @State private var isCalendarPresented = false
    
    var body: some View {
        
        let filterDateBinding = Binding {
            if self.filterDate == .distantPast {
                return Date.now
            }
            return self.filterDate
        } set: { value in
            self.filterDate = value
        }
        
        NavigationStack {
            
            ZStack {
                Color.darkBackground
                    .ignoresSafeArea()
                
                List(memosViewController.memos) { memo in
                    
                    let dayTimeBinding = Binding {
                        return memo.dayTime
                    } set: { value in
                        memo.dayTime = value
                    }
                    
                    Section {
                        
                        Section {
                            Text("\(memo.date.getMemoDay())")
                                .foregroundStyle(.white)
                                .font(.title2)
                                .listRowSeparator(.hidden)
                                .fontWeight(.semibold)
                                .padding(.bottom, -25)
                                .italic()
                            
                            HStack {
                                Text("\(memo.date.getMemoDate())")
                                    .foregroundStyle(.white)
                                    .font(.title3)
                                    .listRowSeparator(.hidden)
                                    .padding(.top, -15)
                                    .padding(.bottom, -20)
                                    .italic()
                                
                                Spacer()
                                
                                memo.highlightFilledDayTimeSymbols()
                                    .listRowSeparator(.hidden)
                            }
                        }
                        .listRowBackground(Color.clear)
                        .listSectionSeparator(.hidden)
                        
                        Section {
                            
                            CustomDividerView(height: 1, color: .aquamarine)
                                .opacity(0.6)
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .padding(.top, -20)
                        }
                        .listRowBackground(Color.clear)
                        .listSectionSeparator(.hidden)
                        
                        Section {
                            
                            PickerView(text: "Day Time", selection: dayTimeBinding) {
                                ForEach(dayTimes, id: \.self) { dayTime in
                                    Text("\(dayTime.capitalized)")
                                }
                            }
                            .listRowSeparator(.hidden)
                            .padding(.top, -30)
                        }
                        .listRowBackground(Color.clear)
                        .listSectionSeparator(.hidden)
                        
                        Section {
                            MemoPreviewView(memo: memo, color: Color.darkBlue)
                        }
                        .listRowBackground(Color.clear)
                        .listSectionSeparator(.hidden)
                    }
                    .padding(.top, 10)
                    .listRowBackground(Color.clear)
                    .listSectionSeparator(.hidden)
                }
                .buttonStyle(.plain)
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .listSectionSeparator(.hidden)
            }
            .navigationTitle("Memos")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isCalendarPresented = true
                    } label: {
                        Image(systemName: "calendar")
                            .foregroundStyle(.lightBlue)
                    }
                    .popoverTip(filterByDateTip)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    if filterDate != .distantPast {
                        Button("Remove Filter") {
                            filterDate = .distantPast
                            memosViewController.isFilterDateApplied = false
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    if isSearchBarPresented {
                        TextField("Filter Text", text: $filterText)
                            .textInputAutocapitalization(.never)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    if isSearchBarPresented {
                        Button("Remove Text Filter", systemImage: "multiply.circle.fill") {
                            filterText = ""
                            isSearchBarPresented = false
                            memosViewController.isFilterTextApplied = false
                        }
                    } else {
                        Button {
                            isSearchBarPresented = true
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.lightBlue)
                        }
                        .popoverTip(filterByTextTip)
                    }
                }
            }
            .onAppear {
                memosViewController.memos = memos
                memosViewController.backupMemos = memos
            }
            .onChange(of: memos) {
                memosViewController.memos = memos
                memosViewController.backupMemos = memos
            }
            .onChange(of: filterDate) {
                memosViewController.isFilterDateApplied = filterDate != .distantPast
                memosViewController.memos = memos
                memosViewController.filterMemoDate(by: filterDate)
            }
            .onChange(of: filterText) {
                memosViewController.isFilterTextApplied = !filterText.isEmpty
                memosViewController.filterMemoText(by: filterText)
            }
            .sheet(isPresented: $isCalendarPresented) {
                CalendarView(date: filterDateBinding)
                    .presentationSizing(.fitted)
                    .presentationDetents([.height(500)])
                    .presentationDragIndicator(.visible)
            }


        }
    }
}

#Preview {
        
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Memo.self, configurations: configuration)

    MemosView()
        .modelContainer(container)
        .environment(MemosViewModel())
        .preferredColorScheme(.dark)
}
