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
        prepareToNewGame()
    }

    private lazy var game = Concetration(numberOfPairsOfCards: numberOfPairsCard)
    var numberOfPairsCard : Int {
        return (cardButtons.count + 1) / 2
        }
    
    private(set) var flipcount = 0.0 { didSet { flipCountLabel.text = "Score: \(flipcount)" }
        }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {

        if let cardNumber = cardButtons.index(of: sender) {
            flipcount = game.count
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    @IBAction func newButton(_ sender: UIButton) {
        prepareToNewGame()
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
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : themeColor[1]
                    if game.arrayComparision == 0 {
                        flipcount = game.count
                        button.isUserInteractionEnabled = false
                    }
            }
        }
        
    }
    
    private var emojiChoices: [String] = []
    
    private var themeColor: [UIColor] = []
    
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
           emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }

    func randomEmoji() -> [String] {
        
        let themes = ["animals","faces","sport","fruits","places","flags"]
        
        let someThemes = themes[themes.count.arc4random]
        
        switch someThemes {
            case "animals":  emojiChoices = ["🐶","🐱","🐭","🐹","🦊","🐥","🐻","🐤"]; themeColor = [#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)]
            case "faces": emojiChoices = ["😀","😇","😍","🤪","🤩","🤯","😱","😰"]; themeColor = [#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)]
            case "sport":  emojiChoices = ["⚽️","🏀","🏈","⚾️","🎾","🏐","🎱","🏉"]; themeColor = [#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)]
            case "fruits":  emojiChoices = ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇"]; themeColor = [#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)]
            case "places":  emojiChoices = ["🏔","🏛","🏥","🏣","🕋","🏭","🌋","🏝"]; themeColor = [#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)]
            case "flags":  emojiChoices = ["🇵🇱","🇪🇸","🇳🇱","🇮🇶","🇮🇩","🇮🇳","🇭🇰","🇮🇷"]; themeColor = [#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)]
            default: print("there is no emojii symbols")
            }
        return emojiChoices
    }
    
    func prepareToNewGame(){
        emoji.removeAll()
        game = Concetration(numberOfPairsOfCards:  (cardButtons.count + 1) / 2)
        emojiChoices = randomEmoji()
        setTheme()
        flipcount = 0
    }
    func setTheme() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = themeColor[1]
            button.isUserInteractionEnabled = true
        }
  
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

