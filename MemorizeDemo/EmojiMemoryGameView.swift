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
            body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(110-90), clockwise: true)
                    .padding(5)
                    .opacity(0.4)
                Text(card.content)
            }
//            .modifier(Cardify(isFaceUp: card.isFaceUp, isMatched: card.isMatched))
            .cardify(isFaceUp: card.isFaceUp, isMatched: card.isMatched)
            .font(Font.system(size: fontSize(for: size)))
        }
    }

    private let fontScaleFactor: CGFloat = 0.7
    
    private func fontSize(for size:CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

struct Memorize_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGameVM())
    }
}
