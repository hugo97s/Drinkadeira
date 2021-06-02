//
//  Card.swift
//  Drinkadeira WatchKit Extension
//
//  Created by Matheus Andrade on 31/05/21.
//

import Foundation

class Card {
    var name: String
    var imageName: String
    var description: String
    
    public init (name: String, imageName: String, description: String) {
        self.name = name
        self.imageName = imageName
        self.description = description
    }
    
    public func getName() -> String {
        return self.name
    }
    
    public func getImageName() -> String {
        return self.imageName
    }
    
    public func getDescription() -> String {
        return self.description
    }
}
