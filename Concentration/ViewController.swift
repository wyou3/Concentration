//
//  ViewController.swift
//  Concentration
//
//  Created by Jin You on 9/10/18.
//  Copyright © 2018 Jin You. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var playAgainButton: UIButton!
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }

    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateCardsView()
            flipCount = game.flipCount
        }
    }
    
    func updateCardsView() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFlipped {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor =  card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5333898357, blue: 0.1419173252, alpha: 1)
            }
            if game.cardsMatched == game.cards.count {
                playAgainButton.isHidden = false
            }
        }
    }

    var emojis = ["💀","👹","🤡","🎃", "👻", "🦇"]
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.id] == nil {
            if emojis.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojis.count)))
                emoji[card.id] = emojis.remove(at: randomIndex)
            }
        }
        
        return emoji[card.id] ?? "?"
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        game.resetGame()
        updateCardsView()
        flipCount = 0
        playAgainButton.isHidden = true
    }
}
