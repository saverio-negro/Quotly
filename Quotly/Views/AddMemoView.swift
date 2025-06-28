//
//  AddMemoView.swift
//  Quotly
//
//  Created by Saverio Negro on 16/12/24.
//

import NaturalLanguage
import SwiftData
import SwiftUI

extension Material: @retroactive View {}

struct AddMemoView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State var memo: Memo
    let tagger = NLTagger(tagSchemes: [.sentimentScore])
    
    @State var title = ""
    @State var text = ""
    @State var isMemoViewPresented = false
    
    @Binding var selectedDayTime: String
    
    func addMemo() {
        let dayTime = selectedDayTime.lowercased()
        
        // Get sentiment score for memo text
        tagger.string = text
        let (sentiment, _) = tagger.tag(at: text.startIndex, unit: .paragraph, scheme: .sentimentScore)
        let sentimentScore = sentiment?.rawValue ?? "0"
        
        memo.dayTime = dayTime
        memo.memoText = text
        print(memo.memoText)
        memo.setIsEmpty(value: "false")
        memo.sentimentScore = sentimentScore == "Other" ? 0 : Double(sentimentScore)!
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.darkBackground
                    .ignoresSafeArea()
                VStack {
                    VStack(alignment: .leading) {
                        Text("Memo for \(Date.convertDateToString(memo.date, format: "MMMM dd yyyy"))")
                            .font(.title2)
                        CustomDividerView(height: 1, color: .aquamarine)
                        VStack {
                            VStack {
                                TextField("Enter your \(selectedDayTime.lowercased()) reflections", text: $text, axis: .vertical)
                                    .lineLimit(10...10)
                            }
                            HStack {
                                Spacer()
                                Button("Add Memo") {
                                    addMemo()
                                    isMemoViewPresented = true
                                }
                                .buttonStyle(.plain)
                                .padding(10)
                                .background(.aquamarine)
                                .clipShape(.buttonBorder)
                                .disabled(text.isEmpty)
                            }
                            .padding(.top, 20)
                        }
                        .padding(.top, 20)
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                    Spacer()
                }
            }
            .fullScreenCover(isPresented: $isMemoViewPresented) {
                self.dismiss()
            } content: {
                MemoView(memo: memo)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Back to Quotes", systemImage: "chevron.backward")
                            .foregroundStyle(.lightBlue)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .navigationTitle("Add Memo")
    }
}

#Preview {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Memo.self, configurations: config)
    AddMemoView(memo: Memo(date: Date.now), selectedDayTime: .constant("Morning"))
            .preferredColorScheme(.dark)
            .modelContainer(container)
}
