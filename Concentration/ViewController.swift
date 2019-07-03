//
//  ViewController.swift
//  Concentration
//
//  Created by Влад Кононенко on 25/06/2019.
//  Copyright © 2019 Влад Кононенко. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Попыток : \(flipCount)"
        }
    }
    
    @IBAction func newGamePressed(_ sender: UIButton) {
        game.ended()
        updateViewFromModel()
        flipCount = 0
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        let cardNumber = cardButtons.firstIndex(of: sender)!
        game.chooseCard(at: cardNumber)
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                flipCount += 1
            }
            else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
    }
    
    // init Dictionary
    var emoji = [Int : String]()
    
    
    func emoji( for card : Card) -> String {
        
        var emojiChoices = chooseTheme()
        
        if emoji[card.identifier] == nil , emojiChoices.count > 0 {
            let randomIndex = Int.random(in: 0..<emojiChoices.count)
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
    func chooseTheme() -> [String] {
        
        // Emoji sets
        var emojiSets = [[String]]()
        
        emojiSets.append(["😈","💀","👹","🎃","👽","👻","🤖","🤡"])
        emojiSets.append(["🥶","🏂","❄️","🛷","⛄️","☁️","🍧","⛸"])
        emojiSets.append(["🐰","🦊","🐷","🐵","🐮","🐸","🐤","🐼"])
        emojiSets.append(["😎","😳","😣","😡","🤩","🙄","😊","🥺","😓","😬"])
        emojiSets.append(["🇦🇺","🇦🇲","🇧🇷","🇧🇮","🇨🇳","🇺🇸","🇨🇿","🇱🇨","🇯🇵","🇷🇺"])
        
        let theme : [String] = emojiSets[Int.random(in: 0..<emojiSets.count)]
            
        return theme
    }
}

