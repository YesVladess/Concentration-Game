//
//  Concentration.swift
//  Concentration
//
//  Created by Влад Кононенко on 25/06/2019.
//  Copyright © 2019 Влад Кононенко. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    
    private(set) var score : Int
    
    private var indexOfOneAndOnlyCardFaceUp: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
            
        }
    }
    
    mutating func chooseCard(at index: Int) {
        
        // Way to protect your API!
        assert(cards.indices.contains(index), "Conectration.chooseCard(at: \(index)) Chosen index out of the cards array!")
        
        if !cards[index].isMatched {
            // check if one card isFaceUp
            if let matchIndex = indexOfOneAndOnlyCardFaceUp, matchIndex != index {
                // check if 2 cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    cards[matchIndex].isFaceUp = false
                    score = score + 2
                } else {
                    // if 2 cards don't match
                    cards[index].isFaceUp = true
                    // let's check if we already seen this pair
                    checkForMissedMatch(pairIdenifier: cards[index])
                    checkForMissedMatch(pairIdenifier: cards[matchIndex])
                    cards[index].wasSeen = true
                }
            }
            else {
                // either no cards or 2 cards are face up
                cards[index].wasSeen = true
                indexOfOneAndOnlyCardFaceUp = index
            }
        }
    }
    
    private mutating func checkForMissedMatch (pairIdenifier seenPairIdentifier: Card) {
        var count = 0
        for flipDownIndex in cards.indices {
            if cards[flipDownIndex] == seenPairIdentifier, cards[flipDownIndex].wasSeen == true {
                count += 1
            }
        }
        if count == 2 {
            score = score - 1
        }
    }
    
    mutating func ended() {
        for flipDownIndex in cards.indices {
            cards[flipDownIndex].isFaceUp = false
            cards[flipDownIndex].isMatched = false
            cards[flipDownIndex].wasSeen = false
        }
        indexOfOneAndOnlyCardFaceUp = nil
        cards.shuffle()
        score = 0
    }
    
    init (numberOfPairsOfCards: Int) {
        
        assert(numberOfPairsOfCards > 0, "Concntration.init: \(numberOfPairsOfCards)) You must at least have one pair of cards!")
        
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards.append(card)
            cards.append(card)
        }
        score = 0
        cards.shuffle()
        
    }
}

extension Collection {
    
    var oneAndOnly : Element? {
        return count == 1 ? first : nil
    }
}
