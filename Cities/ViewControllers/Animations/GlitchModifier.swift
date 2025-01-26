//
//  GlitchModifier.swift
//  Cities
//
//  Created by Jesus Barragan  on 25/01/25.
//

import SwiftUI

struct GlitchModifier: ViewModifier {
    let color: Color
    let offset: CGFloat
    
    func body(content: Content) -> some View {
        content.offset(x: offset / 4).shadow(color: color, radius: 1, x: offset, y: 0)
    }
}
