//
//  Concentration.swift
//  Concentration
//
//  Created by Jin You on 9/11/18.
//  Copyright © 2018 Jin You. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    var numCardPairs: Int?
    var indexOfFaceUpCard: Int?
    var flipCount = 0
    var cardsMatched = 0
    
    init(numberOfPairsOfCards: Int){
        numCardPairs = numberOfPairsOfCards
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards = cards.shuffled()
    }
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched {
            if let matchIndex = indexOfFaceUpCard, matchIndex != index {
                if cards[matchIndex].id == cards[index].id {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    cardsMatched += 2
                }
                flipCount += 1
                cards[index].isFlipped = true
                indexOfFaceUpCard = nil
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFlipped = false
                }
                flipCount += 1
                cards[index].isFlipped = true
                indexOfFaceUpCard = index
            }
        }
    }
    
    func resetGame(){
        for cardIndex in cards.indices {
            cards[cardIndex].isFlipped = false
            cards[cardIndex].isMatched = false
        }
        cards = cards.shuffled()
        indexOfFaceUpCard = nil
        flipCount = 0
        cardsMatched = 0
    }
}

extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            // Change `Int` in the next line to `IndexDistance` in < Swift 4.1
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
