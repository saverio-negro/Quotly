//
//  MemoPreviewView.swift
//  Memos
//
//  Created by Saverio Negro on 26/01/25.
//

import SwiftUI

struct MemoPreviewView: View {
    
    @Bindable var memo: Memo
    
    let color: Color
    let editMemoTip = EditMemoTip()
    
    @State private var isAddMemoViewPresented = false
    @State private var isMemoViewPresented = false
    
    var addMemoButton: some View {
        Button {
            isAddMemoViewPresented = true
        } label: {
            Image(systemName: "plus.circle.fill")
                .foregroundStyle(.aquamarine)
                .font(.title)
                .padding(.horizontal, 5)
                .padding(.vertical, 36.5)
        }
    }
    
    var waitMessage: some View {
        let message = memo.getWaitMessage(for: memo.dayTime)
        return Text(message)
            .foregroundStyle(.white)
            .padding(.horizontal, 5)
            .padding(.vertical, 43)
    }
    
    var addMemoCard: some View {
        
        return VStack {
            if Date.isToday(memo.date) {
                if memo.hasHit(memo.dayTime) {
                    addMemoButton
                } else {
                    waitMessage
                }
            } else {
                addMemoButton
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    var memoPreviewCard: some View {
        
        let title = memo.memoTitle
        let text = memo.memoText
        
        return Group {
            HStack {
                Text("\(title == "" ? "No Title" : title)")
                    .lineLimit(1)
                    .foregroundStyle(.lightBlue)
                    .font(.title)
                    .fontWeight(.medium)
                
                Spacer()
                HStack {
                    
                    Image(systemName: "suit.heart.fill")
                        .font(.system(size: 25.0))
                        .foregroundStyle(.lightBlue)
                        .fontWeight(.bold)
                        .overlay {
                            Text("\(memo.heartNumber)")
                                .foregroundStyle(.darkBackground)
                                .bold()
                        }
                    
                    Button {
                        isMemoViewPresented = true
                    } label: {
                        Image(systemName: "pencil")
                            .font(.system(size: 25.0))
                            .foregroundStyle(.lightBlue)
                            .fontWeight(.bold)
                    }
                    .popoverTip(editMemoTip)
                }
            }
            .padding(.horizontal, 10)
            .padding(.top, 15)
            .padding(.bottom, -4)
            
            CustomDividerView(height: 1, color: Color.aquamarine)
                .opacity(0.6)
            
            Text("\(text == "" ? "No additional text" : text)")
                .lineLimit(3)
                .foregroundStyle(.white)
                .font(.title3)
                .padding(.horizontal, 10)
                .padding(.bottom, 20)
        }
    }
    
    var body: some View {
        
        let isEmpty = !memo.doesEntryExist(for: memo.dayTime)
        
        VStack(alignment: isEmpty ? .center : .leading) {
            
            if isEmpty {
                addMemoCard
            } else {
                memoPreviewCard
            }
        }
        .fullScreenCover(isPresented: $isAddMemoViewPresented, content: { AddMemoView(memo: memo, selectedDayTime: $memo.dayTime) })
        .fullScreenCover(isPresented: $isMemoViewPresented, content: { MemoView(memo: memo)})
        .background(color)
        .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    MemoPreviewView(memo: Memo(date: Date.now), color: .darkBlue)
}
