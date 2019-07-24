//
//  ViewController.swift
//  Concentration
//
//  Created by Влад Кононенко on 25/06/2019.
//  Copyright © 2019 Влад Кононенко. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // init game
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    // init array of emoji
    private lazy var emojiChoices = chooseTheme()
    
    // init Dictionary
    private var emoji = [Card : String]()
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        let cardNumber = cardButtons.firstIndex(of: sender)!
        game.chooseCard(at: cardNumber)
        updateViewFromModel()
    }
    
    @IBAction private func newGamePressed(_ sender: UIButton) {
        game.ended()
        // Forgot the emojis linked to the cards
        emoji = [:]
        // Choose new theme for a brand new game
        emojiChoices = chooseTheme()
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }
            else {
                button.setTitle("", for: UIControl.State.normal)
                if card.isMatched {
                    button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                } else { button.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1) }
            }
        }
        scoreLabel.text = "Счет : \(game.score)"
    }
    
    private func emoji( for card : Card) -> String {
        
        if emoji[card] == nil , emojiChoices.count > 0 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.randomNumber)
        }
        
        return emoji[card] ?? "?"
    }
    
    private func chooseTheme() -> [String] {
        
        // Emoji sets
        var emojiSets = [[String]]()
        
        emojiSets.append(["😈","💀","👹","🎃","👽","👻","🤖","🤡"])
        emojiSets.append(["🥶","🏂","❄️","🛷","⛄️","☁️","🍧","⛸"])
        emojiSets.append(["🐰","🦊","🐷","🐵","🐮","🐸","🐤","🐼"])
        emojiSets.append(["😎","😳","😣","😡","🤩","🙄","😊","🥺","😓","😬"])
        emojiSets.append(["🇦🇺","🇦🇲","🇧🇷","🇧🇮","🇨🇳","🇺🇸","🇨🇿","🇱🇨","🇯🇵","🇷🇺"])
        emojiSets.append(["🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚜","🚛","🚒","🚐","🚚"])
        
        let theme : [String] = emojiSets[Int.random(in: 0..<emojiSets.count)]
            
        return theme
    }
}

extension Int {
    var randomNumber: Int {
        if self > 0 {
            return Int.random(in: 0..<self)
        }
        else if self < 0 {
            return -Int.random(in: 0..<abs(self))
        }
        else  {
            return 0
        }
    }
}

