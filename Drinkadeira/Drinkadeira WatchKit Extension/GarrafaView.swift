//
//  GarrafaView.swift
//  Drinkadeira WatchKit Extension
//
//  Created by Victor Vieira on 31/05/21.
//
import SpriteKit
import WatchKit
import SwiftUI
import UIKit

struct GarrafaView: View {
    @State var didSwipe = false
    let rotationRec = WKTapGestureRecognizer()
    //let gameScene = GameScene(didSwipe: didSwipe)
    
    private var thresholdPercentage: CGFloat = 0.3
    @State var swipeDirection = swipeStatus.none
    
    enum swipeStatus {
        case right, left, none
    }
    
    private func getGesturePercentage(_ width: CGFloat, from gesture: DragGesture.Value) -> CGFloat {
            gesture.translation.width / width
    }
    
    var body: some View {
        SpriteView(scene: GameScene(didSwipe: $didSwipe))
            .onTapGesture {
                didSwipe.toggle()
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if (self.getGesturePercentage(WKInterfaceDevice.current().screenBounds.width, from: value)) >= self.thresholdPercentage {
                            print("right")
                            self.swipeDirection = .right
                            self.didSwipe.toggle()
                        } else if (self.getGesturePercentage(WKInterfaceDevice.current().screenBounds.width, from: value)) <= -self.thresholdPercentage {
                            print("left")
                            self.swipeDirection = .left
                            self.didSwipe.toggle()

                        } else {
                            print("mexeu pouco")
                            self.swipeDirection = .none

                        }
                        
                    }
                    .onEnded { value in
                        print("fim do drag")
                    }
            )
    }
}

struct GarrafaView_Previews: PreviewProvider {
    static var previews: some View {
        GarrafaView()
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
