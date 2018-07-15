//
//  ViewController.swift
//  Concentration
//
//  Created by Alvin Tan De Jun on 30/6/18.
//  Copyright © 2018 Alvin Tan. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {

    private lazy var game = Concentration(numberOfPairsOfCard: numberOfPairsOfCard) // classes get a free init with no arg as long as their variables get initialised
    
    var numberOfPairsOfCard: Int {
        get {
            return (cardButtons.count + 1) / 2
        }
    }
    
    private(set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedStringKey: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            print("cardNumber: \(cardNumber)")
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card is not in cardButtons!")
        }
    }
    
    func updateViewFromModel() {
        if cardButtons != nil {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                } else {
                    button.setTitle("", for: UIControlState.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
                }
            }
        }
    }
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    // private var emojiChoices = ["👻", "🎃", "💀", "👽", "🤖", "🎩", "🐶", "🐱", "🐼"]
    private var emojiChoices = "👻🎃💀👽🤖🎩🐶🐱🐼"
    
    private var emoji = [Card: String]()
    
    private func emoji(for card:Card) -> String {
        /** if emoji[card.identifier] != nil {
            return emoji[card.identifier]
        } else {
            return "?"
        ] **/
        if emoji[card] == nil {
            if emojiChoices.count > 0 {
                let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: Int(arc4random_uniform(UInt32(emojiChoices.count))))
                //let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
            }
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

