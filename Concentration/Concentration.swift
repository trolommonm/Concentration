//
//  Concentration.swift
//  Concentration
//
//  Created by Alvin Tan De Jun on 1/7/18.
//  Copyright © 2018 Alvin Tan. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            /** var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    foundIndex = index
                } else {
                    return nil
                }
            }
            return foundIndex **/
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at Index: Int) {
        assert(cards.indices.contains(Index), "Concentration.chooseCard(at: \(Index)): choosen index is not in the cards)")
        if !cards[Index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != Index {
                // check if cards match
                if cards[Index] == cards[matchIndex] {
                    cards[Index].isMatched = true
                    cards[matchIndex].isMatched = true
                }
                cards[Index].isFaceUp = true
            } else {
                // either 2 cards or no cards are faced up
                indexOfOneAndOnlyFaceUpCard = Index
            }
        }
    }
 
    init(numberOfPairsOfCard: Int) {
        assert(numberOfPairsOfCard > 0, "Concentration.init(\(numberOfPairsOfCard): you must have at least 1 pair of cards")
        for _ in 1...numberOfPairsOfCard {
            let card = Card()
            cards += [card, card] // cards.append(card) 2 times
        }
        // TODO: shuffle the cards
        //cards.shuffle
    }
    
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
