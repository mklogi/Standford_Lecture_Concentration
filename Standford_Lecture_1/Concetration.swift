//
//  Concetration.swift
//  Standford_Lecture_1
//
//  Created by Marcin Kowalczyk on 28.11.2017.
//  Copyright © 2017 Marcin Kowalczyk. All rights reserved.
//

import Foundation


class Concetration {
    
    var count = 0
    
    private(set) var cards = [Card]()
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
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if card match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                }
                
                cards[index].isFaceUp = true
                cards[index].isSeen += 1
                count = counter(at: index)
 
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
       
    }
    func newGame(){
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            cards[index].isSeen = 0
            count = 0
        }
          cards = cards.rounded
    }
    
    func randomEmoji() -> [String] {
        
        var emojiChoices: [String] = []
        
        let themes = ["animals","faces","sport","fruits","places","flags"]
        
        let someThemes = themes[themes.count.arc4random]
        
        switch someThemes {
            case "animals": emojiChoices = ["🐶","🐱","🐭","🐹","🦊","🐥","🐻","🐤"]
            case "faces": emojiChoices = ["😀","😇","😍","🤪","🤩","🤯","😱","😰"]
            case "sport": emojiChoices = ["⚽️","🏀","🏈","⚾️","🎾","🏐","🎱","🏉"]
            case "fruits": emojiChoices = ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇"]
            case "places": emojiChoices = ["🏔","🏛","🏥","🏣","🕋","🏭","🌋","🏝"]
            case "flags": emojiChoices = ["🇵🇱","🇪🇸","🇳🇱","🇮🇶","🇮🇩","🇮🇳","🇭🇰","🇮🇷"]
            default: print("there is no emojii symbols")
        }
        return emojiChoices
    }
    
    func counter(at index: Int) -> Int {
        
        if cards[index].isSeen >= 2 && !cards[index].isMatched{
            count -= 2
        } else if cards[index].isMatched {
            count += 2
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






