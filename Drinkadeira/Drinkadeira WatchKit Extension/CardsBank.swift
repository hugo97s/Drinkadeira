//
//  CardsBank.swift
//  Drinkadeira WatchKit Extension
//
//  Created by Matheus Andrade on 31/05/21.
//

import Foundation

class CardsBank {
    static var shared: CardsBank = CardsBank()
    var cards: [Card]
    
    init() {
        self.cards = [
            Card(name: "ACE", imageName: "CardFront", description: "all guys drink"),
            Card(name: "TWO", imageName: "CardFront", description: "all drink"),
            Card(name: "THREE", imageName: "CardFront", description: "drink 2 shots"),
            Card(name: "FOUR", imageName: "CardFront", description: "pick someone\nto drink"),
            Card(name: "FIVE", imageName: "CardFront", description: "ladies drink"),
            Card(name: "SIX", imageName: "CardFront", description: "find a drinking\nbuddy")
        ]
    }
    
    init(cards: [Card]) {
        self.cards = cards
    }
    
    init(cards: Card...) {
        self.cards = []
        for card in cards {
            self.cards.append(card)
        }
    }
    
    public func getRandomCard() -> Card {
        return self.cards.randomElement()!
    }
}
