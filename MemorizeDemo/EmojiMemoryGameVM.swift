//
//  EmojiMemoryGameVM.swift
//  travelSwiftUIDemo
//
//  Created by 曾国锐 on 2021/10/21.
//

import Foundation

class EmojiMemoryGameVM: ObservableObject {
    @Published private var model: MemoryGameModel<String> = EmojiMemoryGameVM.creatMemoryGame()
    
    private static func creatMemoryGame() -> MemoryGameModel<String> {
        let emojis: Array<String> = ["🐶", "🐱", "🐭", "🐰", "🦊", "🐻", "🐼", "🐯", "🦁"]
        return MemoryGameModel<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
                emojis[pairIndex]
            }
    }
    
    var cards: Array<MemoryGameModel<String>.Card> {
        model.cards
    }
    
    // MARK: - intent
    func choose(card: MemoryGameModel<String>.Card) {
        model.choose(card: card)
    }
    
    func resetGam() {
        model = EmojiMemoryGameVM.creatMemoryGame()
    }
}
