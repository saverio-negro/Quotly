//
//  RotationViewModifier.swift
//  Quotly
//
//  Created by Saverio Negro on 14/12/24.
//

import SwiftUI

enum Axis {
    case x
    case y
    case z
}

extension View {
    func rotation(degrees: Double, axis: Axis) -> some View {
        return self.modifier(RotationViewModifier(degrees: degrees, axis: axis))
    }
}

struct RotationViewModifier: ViewModifier {
    
    let degrees: Double
    let axis: Axis
    
    func getAxis(_ axis: Axis) -> (CGFloat, CGFloat, CGFloat) {
        switch axis {
        case .x:
            return (1, 0, 0)
        case .y:
            return (0, 1, 0)
        case .z:
            return (0, 0, 1)
        }
    }
    
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(Angle.degrees(degrees), axis: getAxis(axis))
    }
}
