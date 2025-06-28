//
//  Untitled.swift
//  Quotly
//
//  Created by Saverio Negro on 14/02/25.
//

import SwiftUI
import TipKit

struct OnboardingView: View {
    
    let quotlyText = Text("Quotly").foregroundStyle(.white).bold()
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.darkBlue, .darkBackground], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            GeometryReader { geometry in
                
                VStack(alignment: .center) {
                    
                    VStack(alignment: .center) {
                        Text("Welcome \nto \(quotlyText)")
                            .foregroundStyle(.lightBlue)
                            .font(.largeTitle)
                            .fontWeight(.medium)
                            .padding()
                    }
                    .padding()
                    
                    Spacer()
                    
                    VStack(alignment: .center) {
                        HStack(spacing: 20) {
                            
                            Image(systemName: "quote.bubble.fill.rtl")
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                
                                Text("Memorable Daily Quotes")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .padding(.bottom, 0)
                                
                                Text("Develop awareness and higher inspiration while being prompted by memorable daily quotes. ")
                                    .foregroundStyle(.lightBlue)
                                    .font(.title3)
                                    .italic()
                            }
                        }
                        .padding(.horizontal, 7)
                        .padding(.vertical, 10)
                        
                        HStack {
                            HStack(spacing: 20) {
                                
                                Image(systemName: "sun.max.fill")
                                    .font(.largeTitle)
                                
                                VStack(alignment: .leading) {
                                    
                                    Text("Morning, Afternoon, and Evening")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .padding(.bottom, 0)
                                    
                                    Text("Carry your daily quote with you throughout the day, and wait for the afternoon and evening to add follow-up memos.")
                                        .foregroundStyle(.lightBlue)
                                        .font(.title3)
                                        .italic()
                                }
                            }
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 10)
                        
                        HStack(spacing: 20) {
                            
                            Image(systemName: "heart.fill")
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                
                                Text("Be Your Beautiful Self")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .padding(.bottom, 0)
                                
                                Text("Remember to always be yourself: being inspired doesn't mean living with the results of other people's life.")
                                    .foregroundStyle(.lightBlue)
                                    .font(.title3)
                                    .italic()
                            }
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 10)
                    }
                    .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    VStack(alignment: .center) {
                        OnboardingButtonView(onPress: {
                            
                            UserDefaults().set(false, forKey: "isOnboarding")
                            
                        })
                        
                    }
                    .frame(maxWidth: .infinity)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
        }
    }
}

#Preview {
    OnboardingView()
}
