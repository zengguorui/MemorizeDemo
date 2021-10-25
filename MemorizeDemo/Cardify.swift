//
//  Cardify.swift
//  MemorizeDemo
//
//  Created by 曾国锐 on 2021/10/25.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    var isFaceUp: Bool
    var isMatched: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)
                content
            } else if !isMatched {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill()
            }
        }
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
}

extension View {
    func cardify(isFaceUp: Bool, isMatched: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, isMatched: isMatched))
    }
}
