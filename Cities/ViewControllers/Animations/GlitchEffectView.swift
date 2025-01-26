//
//  GlitchText.swift
//  Cities
//
//  Created by Jesus Barragan  on 25/01/25.
//

import SwiftUI

struct GlitchEffectView<Content: View>: View {
    let content: Content
    @Binding var isGlitching: Bool
    @State private var offsetRed: CGFloat = 0
    @State private var offsetBlue: CGFloat = 0
    var body: some View {
        ZStack {
            content.opacity(7.0)
            content.modifier(GlitchModifier(color: .red, offset: offsetRed)).opacity(0.4)
            content.modifier(GlitchModifier(color: .blue, offset: offsetBlue)).opacity(0.4)
        }.onChange(of: isGlitching) { newValue in
            if newValue {
                startGlitchAnimation()
            } else {
                resetGlitch()
            }
        }
    }
    
    private func startGlitchAnimation() {
        let duration = 0.3
        let steps = 3
        
        for i in 0...steps {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * duration) {
                withAnimation(.easeInOut(duration: duration)) {
                    offsetRed = CGFloat.random(in: -55...0)
                    offsetBlue = CGFloat.random(in: 0...55)
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(steps), execute: {
            resetGlitch()
            isGlitching = false
        })
    }
    
    private func resetGlitch() {
        withAnimation(.easeIn(duration: 0.1)) {
            offsetRed = 0
            offsetBlue = 0
        }
    }
}
