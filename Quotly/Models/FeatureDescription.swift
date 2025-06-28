//
//  FeatureDescription.swift
//  Quotly
//
//  Created by Saverio Negro on 14/02/25.
//

import SwiftUI

struct FeatureDescription: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var image: String
    var gradientColors: [Color]
}
