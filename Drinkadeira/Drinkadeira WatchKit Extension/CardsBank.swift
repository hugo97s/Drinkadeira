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
            Card(name: "Tsunami", imageName: "As", description: "Todos bebem"),
            Card(name: "Amigo da onça", imageName: "Dois", description: "Escolha dois amigos para beber"),
            Card(name: "Três patetas", imageName: "Tres", description: "Escolha dois amigos para beber com você"),
            Card(name: "Cachorrinho", imageName: "Quatro", description: "Beba na posição do cachorrinho"),
            Card(name: "Volta bebê, volta neném", imageName: "Cinco", description: "Beba ou ligue para seu/sua ex"),
            Card(name: "Vivo morto", imageName: "Seis", description: "Bebe quem estiver de pé"),
            Card(name: "Seu animal", imageName: "Sete", description: "Imite um animal e beba igual a ele"),
            Card(name: "Molhando o biscoito", imageName: "Oito", description: "Escolha duas pessoas para se beijarem ou beberem juntas"),
            Card(name: "Morto vivo", imageName: "Nove", description: "Bebe quem não estiver de pé"),
            Card(name: "Desespero", imageName: "Dez", description: "Faça um pix de 2 reais para o próximo sorteado ou beba"),
            Card(name: "Valente", imageName: "Valete", description: "Desafie alguém no Jokenpo. Quem perder, bebe"),
            Card(name: "Rainha do funk", imageName: "Rainha", description: "Beba ou rebole até o chão"),
            Card(name: "Seu rei mandou", imageName: "Rei", description: "Deixe que publiquem algo nas suas redes ou beba 2x"),
            Card(name: "Pregando peça", imageName: "Coringa", description: "Todos bebem. Escolha alguém para pagar prenda")
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
