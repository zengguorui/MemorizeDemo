//
//  MemoryGameData.swift
//  travelSwiftUIDemo
//
//  Created by 曾国锐 on 2021/10/21.
//

import Foundation
import SwiftUI

struct MemoryGameModel <CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp }.only
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        if let choseIndex: Int = cards.firstIndex(matching: card), !cards[choseIndex].isFaceUp, !cards[choseIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[choseIndex].content == cards[potentialMatchIndex].content {
                    cards[choseIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                self.cards[choseIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = choseIndex
            }

            print("card choose: %s \(card)")
        }
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
