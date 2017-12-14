//
//  ViewController.swift
//  Standford_Lecture_1
//
//  Created by Marcin Kowalczyk on 28.11.2017.
//  Copyright © 2017 Marcin Kowalczyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
    override func viewDidLoad() {
        emojiChoices = game.randomEmoji()
    }

    private lazy var game = Concetration(numberOfPairsOfCards: numberOfPairsCard)
    var numberOfPairsCard : Int {
        return (cardButtons.count + 1) / 2
        }
    
    private(set) var flipcount = 0 { didSet { flipCountLabel.text = "Flips: \(flipcount)" }
        }
    private var newGame = false
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipcount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    @IBAction func newButton(_ sender: UIButton) {
        flipcount = 0
        game.newGame()
        emojiChoices = game.randomEmoji()
        newGame = true
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }
    }
    
    private func updateViewFromModel(){
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        
    }
    
    private var emojiChoices: [String] = []
    
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String {
        
        if newGame == true {
            emoji.removeAll()
            emojiChoices = game.randomEmoji()
            newGame = false
        }
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
           emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
 
        }
        
        return emoji[card.identifier] ?? "?"
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

