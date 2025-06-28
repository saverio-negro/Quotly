//
//  MemoView.swift
//  Memos
//
//  Created by Saverio Negro on 24/01/25.
//

import SwiftUI
import TipKit

struct MemoView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var isDeleteAlertShowing = false
    
    @Bindable var memo: Memo
    
    let vibesRatingTip = VibesRatingTip()
    
    var body: some View {
        
        let sentimentScore = Binding {
            return String(memo.sentimentScore)
        } set: { value in
            memo.sentimentScore = (value == "Other" ? 0 : Double(value)!)
        }

        NavigationStack {
            ZStack {
                
                Color.darkBackground
                    .ignoresSafeArea()
                
                VStack {
                    
                    Text("\(memo.date.getMemoDay().capitalized)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.lightBlue)
                        .padding(.top, 10)
                    
                    Text("\(memo.dayTime.capitalized)")
                        .font(.title3)
                        .foregroundStyle(.lightBlue)
                    
                    VibesRatingView(vibesRating: $memo.sentimentScore)
                        .padding()
                    
                    TipView(vibesRatingTip)
                        .padding()
                    
                    CustomDividerView(height: 1, color: Color.aquamarine)
                        .opacity(0.6)
                    
                    Text("\(memo.quote?.text ?? "No Quote") \n\n — \(memo.quote?.author ?? "Unknown Author")")
                        .foregroundStyle(.white)
                        .italic()
                        .padding()
                    
                    CustomDividerView(height: 1, color: Color.aquamarine)
                        .opacity(0.6)
                    
                    MemoCardView(memo: memo, color: Color.darkBlue, sentimentScore: sentimentScore)
                        .padding()
                    Spacer()
                }
            }
            .navigationTitle("\(memo.date.getMemoDate())")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitleTextColor(Color.lightBlue)
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        
                        modelContext.insert(memo)
                        
                        if memo.shouldBeDeleted() {
                            
                            memo.entries[memo.dayTime]!["isEmpty"] = "true"
                            
                            if memo.isEmpty {
                                modelContext.delete(memo)
                            }
                        }
                        
                        dismiss()
                        
                    } label: {
                        Label("Go Back to Memos", systemImage: "chevron.backward")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isDeleteAlertShowing = true
                    } label: {
                        Image(systemName: "trash")
                            .foregroundStyle(Color.lightBlue)
                    }
                    .alert("Delete Memo", isPresented: $isDeleteAlertShowing) {
                        Button("Delete", role: .destructive) {
                            
                            memo.entries[memo.dayTime]!["title"] = ""
                            memo.entries[memo.dayTime]!["text"] = ""
                            memo.entries[memo.dayTime]!["isEmpty"] = "true"
                            
                            if memo.isEmpty {
                                modelContext.delete(memo)
                            }
                            
                            dismiss()
                        }
                        
                        Button("Cancel", role: .cancel, action: {})
                    } message: {
                        Text("Are you sure? This will delete the \(memo.dayTime)'s memo for \(memo.date.getMemoDay()) \(memo.date.getMemoDate())")
                    }
                }
            }
        }
    }
}

#Preview {
    MemoView(memo: Memo(date: Date.now))
}
