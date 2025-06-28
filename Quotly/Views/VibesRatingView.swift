//
//  VibesRatingView.swift
//  Memos
//
//  Created by Saverio Negro on 10/02/25.
//

import SwiftUI

struct VibesRatingView: View {
    
    @Binding var vibesRating: Double
    let ratings = [-1.0, -0.5, 0, 0.5, 1.0]
    
    var offImage: Image = Image(systemName: "suit.heart")
    var onImage: Image = Image(systemName: "suit.heart.fill")
    
    func image(for num: Double) -> Image {
        return num > vibesRating ? offImage : onImage
    }
    
    var body: some View {
        HStack {
            ForEach(ratings, id: \.self) { rating in
                image(for: rating)
                    .foregroundStyle(.lightBlue)
                    .font(.title2)
            }
        }
    }
}

#Preview {
    VibesRatingView(vibesRating: .constant(-1.0))
}
