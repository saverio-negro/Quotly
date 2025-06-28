//
//  QuoteCardView.swift
//  Quotly
//
//  Created by Saverio Negro on 14/12/24.
//

import SwiftUI

struct QuoteCardView: View {
    
    let memo: Memo?
    let author: String
    let text: String
    @State var degrees = 0
    @Binding var selectedWeekDay: Int
    var doesMemoExist: Bool {
        return memo != nil
    }
    
    var body: some View {
        GeometryReader { geometry in
            
            LinearGradient(colors: [.clear], startPoint: .topLeading, endPoint: .bottomTrailing)
                .clipShape(.rect(cornerRadius: 10))
                .frame(minHeight: 200)
                .overlay {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.clear)
                        VStack {
                            
                            Spacer()
                            
                            // Quote
                            VStack {
                                VStack {
                                    Text("\(text)")
                                        .font(.title3)
                                        .bold()
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(5)
                                }
                                
                                VStack {
                                    HStack {
                                        Spacer()
                                        Text("— \(author)")
                                            .font(.headline)
                                    }
                                    .padding(.horizontal, 15)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.top, 5)
                            }
                            
                            Spacer()
                            
                            // Edit-Quote Button
                            VStack {
                                HStack {
                                    Spacer()
                                    QuoteImagePickerView(selectedWeekDay: $selectedWeekDay)
                                        .disabled(doesMemoExist)
                                }
                            }
                        }
                        .frame(maxHeight: .infinity)
                        .padding(20)
                    }
                }
                .blendMode(.sourceAtop)
                .animation(Animation.linear(duration: 0.1), value: selectedWeekDay)
        }
    }
}

#Preview {
    QuoteCardView(memo: Memo(date: .now), author: "Virginia Woolf", text: "You cannot find peace by avoiding life.", selectedWeekDay: .constant(0))
        .preferredColorScheme(.dark)
        .environment(WeekDaysViewModel())
}
