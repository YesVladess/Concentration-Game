//
//  Concentration.swift
//  Concentration
//
//  Created by Влад Кононенко on 25/06/2019.
//  Copyright © 2019 Влад Кононенко. All rights reserved.
//

import Foundation

class Concentration{
    
    var cards = [Card]()
    
    var indexOfOneAndOnlyCardFaceUp: Int?
    
    func chooseCard(at index: Int) {
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyCardFaceUp, matchIndex != index {
                // check if 2 cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyCardFaceUp = nil
            }
            else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyCardFaceUp = index
            }
        }
        
    }
    
    func ended() {
        for flipDownIndex in cards.indices {
            cards[flipDownIndex].isFaceUp = false
            cards[flipDownIndex].isMatched = false
            indexOfOneAndOnlyCardFaceUp = nil
            mixCards()
        }
    }
    
    func mixCards() {
        
        var newIndexes = [Int](1...cards.count/2)
        let newIndexes2 = [Int](1...cards.count/2)
        newIndexes = newIndexes + newIndexes2
        
        for index in cards.indices {
            
            let newCardIdentifier = Int.random(in: 0..<newIndexes.count)
            cards[index].identifier = newIndexes[newCardIdentifier]
            newIndexes.remove(at: newCardIdentifier)
        }
        
    }
    
    init (numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            
            let card = Card()
            cards.append(card)
            cards.append(card)
            //cards += [card, card]
        }
        mixCards()
    }
}
