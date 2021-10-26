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
        
        VStack {
            Grid(viewModel.cards) { card in
                CardView(card: card)
                    .onTapGesture{
                        withAnimation(.linear(duration: 0.75)) {
                            viewModel.choose(card: card)
                        }
                    }
                    .padding(5)
            }
            .foregroundColor(.orange)
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
            
            Button {
                withAnimation(.easeInOut) {
                    self.viewModel.resetGam()
                }
            } label: {
                Text("重置")
            }

        }
    }
}

struct CardView: View {
    
    var card: MemoryGameModel<String>.Card
    
    var body: some View {
        
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining : Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemainning
        withAnimation(.linear(duration: card.bonusRemainning)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                if card.isConsumingBonusTime {
                    Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-animatedBonusRemaining * 360 - 90), clockwise: true)
                        .padding(5)
                        .opacity(0.4)
                        .onAppear {
                            startBonusTimeAnimation()
                        }
                } else {
                    Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-card.bonusRemainning * 360 - 90), clockwise: true)
                        .padding(5)
                        .opacity(0.4)
                }
                
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
//            .modifier(Cardify(isFaceUp: card.isFaceUp))
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
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
