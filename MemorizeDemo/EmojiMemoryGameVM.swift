//
//  EmojiMemoryGameVM.swift
//  travelSwiftUIDemo
//
//  Created by ζΎε½ι on 2021/10/21.
//

import Foundation

class EmojiMemoryGameVM: ObservableObject {
    @Published private var model: MemoryGameModel<String> = EmojiMemoryGameVM.creatMemoryGame()
    
    private static func creatMemoryGame() -> MemoryGameModel<String> {
        let emojis: Array<String> = ["πΆ", "π±", "π­", "π°", "π¦", "π»", "πΌ", "π―", "π¦"]
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
