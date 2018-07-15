//
//  Card.swift
//  Concentration
//
//  Created by Alvin Tan De Jun on 1/7/18.
//  Copyright © 2018 Alvin Tan. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    var hashValue: Int { return identifier }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIndentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIndentifier()
    }
    
}
