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
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var id = UUID()
        var isFaceUp: Bool = false {
            didSet {
                isFaceUp ? startUsingBonusTime() : stopUsingBonusTime()
            }
        }
        var isMatched: Bool = false {
            didSet {
                if isMatched {
                    stopUsingBonusTime()
                }
            }
        }
        var content: CardContent
        
        //MARK: - 计分
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemainning: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemainning : Double {
            (bonusTimeLimit > 0 && bonusTimeRemainning > 0) ? bonusTimeRemainning / bonusTimeLimit : 0
        }
        
        var hasEarnedBonus : Bool {
            isMatched && bonusTimeRemainning > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemainning > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}
