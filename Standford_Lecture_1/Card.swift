//
//  Card.swift
//  Standford_Lecture_1
//
//  Created by Marcin Kowalczyk on 28.11.2017.
//  Copyright © 2017 Marcin Kowalczyk. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var isSeen = false
    var identifier: Int

    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
   
    
}
