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
            Card(name: "ÁS", imageName: "CardFront", description: "todos os homens bebem"),
            Card(name: "DOIS", imageName: "CardFront", description: "todos bebem"),
            Card(name: "TRÊS", imageName: "CardFront", description: "beba dois copos"),
            Card(name: "QUATRO", imageName: "CardFront", description: "escolha alguém para beber"),
            Card(name: "CINCO", imageName: "CardFront", description: "todas as mulheres bebem"),
            Card(name: "SEIS", imageName: "CardFront", description: "escolha um parceiro de bebida")
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
