//
//  MemoCardView.swift
//  Memos
//
//  Created by Saverio Negro on 26/01/25.
//

import NaturalLanguage
import SwiftUI

struct MemoCardView: View {
    
    let memo: Memo
    let color: Color
    let tagger = NLTagger(tagSchemes: [.sentimentScore])
    @Binding var sentimentScore: String
    
    var body: some View {
        
        let bindingMemoTitle = Binding {
            return memo.entries[memo.dayTime]!["title"]!
        } set: { value in
            memo.entries[memo.dayTime]!["title"]! = value
        }

        let bindingMemoText = Binding {
            
            return memo.entries[memo.dayTime]!["text"]!
            
        } set: { value in
            
            memo.entries[memo.dayTime]!["text"]! = value
            tagger.string = value
            let (sentiment, _) = tagger.tag(at: value.startIndex, unit: .paragraph, scheme: .sentimentScore)
            sentimentScore = sentiment?.rawValue ?? "0"
        }

        VStack {
            
            TextField("Memo Title", text: bindingMemoTitle)
                .foregroundStyle(.lightBlue)
                .font(.title)
                .fontWeight(.medium)
                .scrollContentBackground(.hidden)
                .padding()
                
                VStack {
                    TextEditor(text: bindingMemoText)
                        .font(.title3)
                        .scrollContentBackground(.hidden)
                        .background(color)
                        .padding()
                }
                .foregroundStyle(.white)
                .background(color)
                .clipShape(.rect(cornerRadius: 10))
                .frame(maxHeight: 250)
        }
    }
}

#Preview {
    MemoCardView(memo: Memo(date: Date.now), color: Color.darkBlue, sentimentScore: .constant("0.7"))
}
