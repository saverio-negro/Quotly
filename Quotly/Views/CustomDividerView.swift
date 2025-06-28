//
//  CustomDividerView.swift
//  Quotly
//
//  Created by Saverio Negro on 15/12/24.
//

import SwiftUI

struct CustomDividerView: View {
    
    let height: CGFloat
    let color: Color
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: height)
    }
}

#Preview {
    CustomDividerView(height: 1, color: .aquamarine)
}
