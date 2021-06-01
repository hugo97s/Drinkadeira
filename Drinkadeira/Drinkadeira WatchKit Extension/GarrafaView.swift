//
//  GarrafaView.swift
//  Drinkadeira WatchKit Extension
//
//  Created by Victor Vieira on 31/05/21.
//
import SpriteKit
import SwiftUI
import UIKit



struct GarrafaView: View {
    let rotationRec = WKTapGestureRecognizer()
    //let gameScene = GameScene(didSwipe: didSwipe)
    @State var didSwipe = false
    var body: some View {
        SpriteView(scene: GameScene(didSwipe: $didSwipe))
            .onTapGesture {
                didSwipe.toggle()
            }
    }
}

struct GarrafaView_Previews: PreviewProvider {
    static var previews: some View {
        GarrafaView(didSwipe: true)
    }
}

class GameScene: SKScene {
    
    var garrafa: SKSpriteNode = SKSpriteNode(imageNamed: "garrafa")
    @Binding var didSwipe: Bool
    
    init(didSwipe: Binding<Bool>) {
        self._didSwipe = didSwipe
        super.init(size: CGSize(width: 197, height: 162))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func sceneDidLoad() {
        self.backgroundColor = .clear
        garrafa.position = CGPoint(x: 100, y: 80)
        garrafa.scale(to: CGSize(width: 52, height: 151.77))
        self.addChild(garrafa)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if(didSwipe){
            let randomAngle = Double.random(in: 18.84...37.68)
            let randomDuration = Double.random(in: 4...5)
            let rotateAction = SKAction.rotate(byAngle: CGFloat(randomAngle), duration: randomDuration)
            garrafa.run(rotateAction)
            didSwipe = false
        }
    }
    
    @objc func rotatedView(_ sender:WKSwipeGestureRecognizer){
        
    }
}
