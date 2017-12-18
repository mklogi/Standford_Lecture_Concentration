//
//  Concetration.swift
//  Standford_Lecture_1
//
//  Created by Marcin Kowalczyk on 28.11.2017.
//  Copyright © 2017 Marcin Kowalczyk. All rights reserved.
//

import Foundation

class Concetration {

    private var startingTime = Date()
    
    var count = 0.0
    
    private var arrayComparision = 0
    
    private(set) var cards = [Card]()
    private var matchedValuesArray = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex : Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set{
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)

            }
        }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concetration.chooseCard(at: \(index)): chosen index is not in the cards")
        
        cards[index].isSeen += 1
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if card match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    matchedValuesArray += [cards[matchIndex], cards[index]]
                }
                
                cards[index].isFaceUp = true

            } else {
                
                indexOfOneAndOnlyFaceUpCard = index
            }
    
            count = counter(at: index)
        }
 
    }
    
    func newGame(){
        startingTime = Date()
        matchedValuesArray.removeAll()
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            cards[index].isSeen = 0
            count = 0
        }
          cards = cards.rounded
    }
    
    func counter(at index: Int) -> Double {
        
        arrayComparision = cards.count - matchedValuesArray.count

        if cards[index].isSeen >= 2 && !cards[index].isMatched {
            count -= 1
        } else if cards[index].isMatched {
           count += 2
        }
        
        if arrayComparision == 0 {
            print(count)
            let endingTime = Date()
            let interval = Double(endingTime.timeIntervalSince(startingTime))
            print(interval)
            if interval < 20.0 {
                count += 20
            } else if interval > 20.0 {
                count += 10
            } else if interval > 30.0 {
                count += 5
            } else {
                count = count - 10
            }
            print(count)
        }
   
        return count
            
    }
   
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concetration.init(\(numberOfPairsOfCards)): you must have at least on pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards = cards.rounded
    }

}

// MARK: Extension

extension Sequence where Iterator.Element == Card {
    var rounded: [Card] {
        var newArray: [Card] = []
        var array = Array(self)
        for _ in 1...array.count {
            let numberOfMixedCard = array.count.arc4random
            newArray.append(array[numberOfMixedCard])
            array.remove(at: numberOfMixedCard)
        }
        return newArray
    }
}






