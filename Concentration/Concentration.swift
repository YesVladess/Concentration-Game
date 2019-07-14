//
//  Concentration.swift
//  Concentration
//
//  Created by Влад Кононенко on 25/06/2019.
//  Copyright © 2019 Влад Кононенко. All rights reserved.
//

import Foundation

class Concentration{
    
    private(set) var cards = [Card]()
    
    private(set) var score : Int
    
    private var indexOfOneAndOnlyCardFaceUp: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    }
                    else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
            
        }
    }
    
    func chooseCard(at index: Int) {
        
        // Way to protect your API!
        assert(cards.indices.contains(index), "Conectration.chooseCard(at: \(index)) Chosen index out of the cards array!")
        
        if !cards[index].isMatched {
            // check if one card isFaceUp
            if let matchIndex = indexOfOneAndOnlyCardFaceUp, matchIndex != index {
                // check if 2 cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    cards[matchIndex].wasSeen = false
                    cards[index].wasSeen = false
                    score = score + 2
                }
                // if 2 cards don't match
                cards[index].isFaceUp = true
                // let's check if we already seen this pair
                checkForMissedMatch(pairIdenifier: cards[index].identifier)
                checkForMissedMatch(pairIdenifier: cards[matchIndex].identifier)
                cards[index].wasSeen = true
            }
            else {
                // either no cards or 2 cards are face up
                cards[index].wasSeen = true
                indexOfOneAndOnlyCardFaceUp = index
            }
        }
    }
    
    private func checkForMissedMatch (pairIdenifier seenPairIdentifier : Int) {
        var count = 0
        for flipDownIndex in cards.indices {
            if cards[flipDownIndex].identifier == seenPairIdentifier, cards[flipDownIndex].wasSeen == true {
                count += 1
            }
        }
        if count == 2 {
            score = score - 1
        }
    }
    
    func ended() {
        for flipDownIndex in cards.indices {
            cards[flipDownIndex].isFaceUp = false
            cards[flipDownIndex].isMatched = false
            cards[flipDownIndex].wasSeen = false
            indexOfOneAndOnlyCardFaceUp = nil
            mixCards()
            score = 0
        }
    }
    
    func mixCards() {
        
        var newIndexes = [Int](1...cards.count/2) + [Int](1...cards.count/2)
        for index in cards.indices {
            let newCardIdentifier = Int.random(in: 0..<newIndexes.count)
            cards[index].identifier = newIndexes[newCardIdentifier]
            newIndexes.remove(at: newCardIdentifier)
        }
        
    }
    
    init (numberOfPairsOfCards: Int) {
        
        assert(numberOfPairsOfCards > 0, "Concntration.init: \(numberOfPairsOfCards)) You must at least have one pair of cards!")
        
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards.append(card)
            cards.append(card)
            //cards += [card, card]
        }
        score = 0
        mixCards()
        
    }
}
