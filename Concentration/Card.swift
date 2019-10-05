//
//  Card.swift
//  Concentration
//
//  Created by Влад Кононенко on 25/06/2019.
//  Copyright © 2019 Влад Кононенко. All rights reserved.
//

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var wasSeen = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
        
    }
    
}

extension Card: Hashable {
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
}

extension Card {
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
