//
//  MemoryGameData.swift
//  travelSwiftUIDemo
//
//  Created by 曾国锐 on 2021/10/21.
//

import Foundation
import SwiftUI

struct MemoryGameModel <CardContent> {
    var cards: Array<Card>
    
    mutating func choose(card: Card) {
        let choseIndex: Int = cards.firstIndex(matching: card)
        self.cards[choseIndex].isFaceUp = !self.cards[choseIndex].isFaceUp
        print("card choose: %s \(card)")
    }

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    struct Card: Identifiable {
        var id = UUID()
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
