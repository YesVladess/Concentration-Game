//
//  CardButton.swift
//  Concentration
//
//  Creatxed by Viktor Sokolov on 10/5/19.
//  Copyright © 2019 Влад Кононенко. All rights reserved.
//

import UIKit

class CardButton: UIButton {
    var emoji: String?
    
    var card: Card? {
        didSet {
            if let card = self.card {
                if (oldValue?.isFaceUp != card.isFaceUp || oldValue?.isMatched != card.isMatched) {
                    if card.isFaceUp {
                        self.setTitle(self.emoji, for: UIControl.State.normal)
                        self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                        UIView.transition(
                            with: self,
                            duration: 0.5,
                            options: .transitionFlipFromRight,
                            animations: nil,
                            completion: nil
                        )
                    } else {
                        self.setTitle("", for: UIControl.State.normal)
                        if (card.isMatched) {
                            UIView.transition(
                                with: self,
                                duration: 0.2,
                                options: .transitionCrossDissolve,
                                animations: nil,
                                completion: nil
                            )
                            self.backgroundColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                        } else {
                            UIView.transition(
                                with: self,
                                duration: 0.5,
                                options: .transitionFlipFromRight,
                                animations: nil,
                                completion: nil
                            )
                            self.backgroundColor =  #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
                        }
                    }
                }
            }
        }
    }
}
