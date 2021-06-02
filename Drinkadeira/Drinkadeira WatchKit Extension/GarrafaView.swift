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

public enum SwipeStatus {
    case right, left, none
}

struct GarrafaView: View {
    @State var didSwipe = false
    @State var swipeDirection = SwipeStatus.none
    @State var showCards = false
    
    private var thresholdPercentage: CGFloat = 0.3
    
    private func getGesturePercentage(_ width: CGFloat, from gesture: DragGesture.Value) -> CGFloat {
            gesture.translation.width / width
    }
    
    var body: some View {
        ZStack {
            SpriteView(scene: GameScene(didSwipe: $didSwipe, direction: $swipeDirection))
                .opacity(self.showCards ? 0 : 1)
                .onTapGesture {
                    print("touch bottle")
                    
                    if didSwipe {
                        self.showCards = true
                        print("show cards")
                    }
                    
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            print(value.startLocation)
                            if (self.getGesturePercentage(WKInterfaceDevice.current().screenBounds.width, from: value)) >= self.thresholdPercentage {
                                if (WKInterfaceDevice.current().screenBounds.height / 2 > value.startLocation.y) {
                                    self.swipeDirection = .right
                                }
                                else{
                                    self.swipeDirection = .left
                                }
                                
                                self.didSwipe = true
                            } else if (self.getGesturePercentage(WKInterfaceDevice.current().screenBounds.width, from: value)) <= -self.thresholdPercentage {
                                if (WKInterfaceDevice.current().screenBounds.height / 2 > value.startLocation.y) {
                                    self.swipeDirection = .left
                                }
                                else{
                                    self.swipeDirection = .right
                                }
                                self.didSwipe = true

                            } else {
                                self.swipeDirection = .none
                                self.didSwipe = false
                            }
                        }
            )
            
            CardView(show: self.$showCards)
                .opacity(self.showCards ? 1 : 0)
        }
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
    @Binding var direction: SwipeStatus
    
    init(didSwipe: Binding<Bool>, direction: Binding<SwipeStatus>) {
        self._didSwipe = didSwipe
        self._direction = direction
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
        if direction != .none {
            let randomAngle = Double.random(in: 18.84...37.68)
            let randomDuration = Double.random(in: 4...5)
            let rotateAction = SKAction.rotate(byAngle: (direction == .right) ? -CGFloat(randomAngle) : CGFloat(randomAngle), duration: randomDuration)
            garrafa.run(rotateAction)
            direction = .none
        }
    }
    
    @objc func rotatedView(_ sender:WKSwipeGestureRecognizer){
        
    }
}
