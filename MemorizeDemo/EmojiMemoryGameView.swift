//
//  Memorize.swift
//  travelSwiftUIDemo
//
//  Created by 曾国锐 on 2021/10/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGameVM
    
    var body: some View {
        
        Grid(viewModel.cards) { card in
            CardView(card: card)
                .onTapGesture{
                    viewModel.choose(card: card)
                }
                .padding(5)
        }
        .foregroundColor(.orange)
        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
    }
}

struct CardView: View {
    
    var card: MemoryGameModel<String>.Card
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.white)
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(lineWidth: edgeLineWidth)
                    Text(card.content)
                } else if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill()
                }
            }
            .font(Font.system(size: fontSize(for: geometry.size)))
        }
    }
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    let fontScaleFactor: CGFloat = 0.75
    
    func fontSize(for size:CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

struct Memorize_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGameVM())
    }
}
