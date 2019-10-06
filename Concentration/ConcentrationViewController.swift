//
//  ConcentrationViewController.swift
//  Concentration
//
//  Created by Влад Кононенко on 25/06/2019.
//  Copyright © 2019 Влад Кононенко. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    // init game
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    // init array of emoji
    private lazy var emojiChoices = chooseTheme()
    
    // init Dictionary
    private var emoji = [Int : String]()
    
    var theme : String? {
        didSet {
            emoji = [:]
            emojiChoices = chooseTheme(themeChoice: theme!)
            setupEmojiForCards()
            updateViewFromModel()
        }
    }
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet private weak var scoreLabel: UILabel! {
        didSet {
            updateGameScoreLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [CardButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEmojiForCards()
        updateViewFromModel()
    }
    
    private func setupEmojiForCards() {
        if cardButtons != nil {
            cardButtons.enumerated().forEach { (index, button) in
                let card = game.cards[index]
                button.emoji = self.emoji(for: card)
            }
        }
    }
    
    @IBAction private func touchCard(_ sender: CardButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    @IBAction private func newGamePressed(_ sender: CardButton) {
        game.ended()
        // Forgot the emojis linked to the cards
        emoji = [:]
        // Choose new theme for a brand new game
        emojiChoices = chooseTheme()
        setupEmojiForCards()
        updateViewFromModel()
    }
    
    private func updateGameScoreLabel() {
        let attributes : [NSAttributedString.Key : Any ] = [
            //.strokeWidth : 2.0,
            .strokeColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Счет : \(game.score)", attributes: attributes)
        scoreLabel.attributedText = attributedString
    }
    
    private func updateViewFromModel() {
        if cardButtons != nil {
            cardButtons.enumerated().forEach { (index, button) in
                button.card = game.cards[index]
            }
            updateGameScoreLabel()
        }
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil , emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.randomNumber)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    private func chooseTheme(themeChoice : String = "") -> [String] {
        // Emoji sets
        var emojiSets = [[String]]()
        emojiSets.append(["😈","💀","👹","🎃","👽","👻","🤖","🤡"])
        emojiSets.append(["🥶","🏂","❄️","🛷","⛄️","☁️","🍧","⛸"])
        emojiSets.append(["🐰","🦊","🐷","🐵","🐮","🐸","🐤","🐼"])
        emojiSets.append(["😎","😳","😣","😡","🤩","🙄","😊","🥺","😓","😬"])
        emojiSets.append(["🇦🇺","🇦🇲","🇧🇷","🇧🇮","🇨🇳","🇺🇸","🇨🇿","🇱🇨","🇯🇵","🇷🇺"])
        emojiSets.append(["🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚜","🚛","🚒","🚐","🚚"])
        switch themeChoice {
        case "Halloween":
            return emojiSets[0]
        case "Winter":
            return emojiSets[1]
        case "Animals":
            return emojiSets[2]
        case "Faces":
            return emojiSets[3]
        case "Flags":
            return emojiSets[4]
        case "Cars":
            return emojiSets[5]
        default:
            return emojiSets[Int.random(in: 0..<emojiSets.count)]
        }
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
