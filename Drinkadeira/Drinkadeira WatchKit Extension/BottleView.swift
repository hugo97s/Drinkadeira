//
//  GarrafaView.swift
//  Drinkadeira WatchKit Extension
//
//  Created by Victor Vieira on 31/05/21.
//
import SpriteKit
import WatchKit
import SwiftUI

public enum RotationStatus {
    case clockwise, anticlockwise, none
}

struct BottleView: View {
    @State var didSwipe = false
    @State var rotationDirection: RotationStatus = .none
    @State var showCards = false
    @EnvironmentObject var endedRotation: Boolean
    
    private var thresholdPercentage: CGFloat = 0.3
    var scene: GameScene {
        let scene = GameScene(didSwipe: $didSwipe, direction: $rotationDirection, endedRotation: _endedRotation)
        return scene
    }
    
    private func getGesturePercentage(_ width: CGFloat, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / width
    }
    
    var body: some View {
        ZStack {
            ZStack(alignment: .center){
                SpriteView(scene: scene)
                    .opacity(self.showCards ? 0 : 1)
                    .onTapGesture {
                        if didSwipe && endedRotation.booleano {
                            self.showCards = true
                            self.didSwipe = false
                            print("show cards")
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                print(value.startLocation)
                                if (self.getGesturePercentage(WKInterfaceDevice.current().screenBounds.width, from: value)) >= self.thresholdPercentage {
                                    if (WKInterfaceDevice.current().screenBounds.height / 2 > value.startLocation.y) {
                                        self.rotationDirection = .clockwise
                                    }
                                    else{
                                        self.rotationDirection = .anticlockwise
                                    }
                                    
                                    self.didSwipe = true
                                } else if (self.getGesturePercentage(WKInterfaceDevice.current().screenBounds.width, from: value)) <= -self.thresholdPercentage {
                                    if (WKInterfaceDevice.current().screenBounds.height / 2 > value.startLocation.y) {
                                        self.rotationDirection = .anticlockwise
                                    }
                                    else{
                                        self.rotationDirection = .clockwise
                                    }
                                    self.didSwipe = true
                                    
                                } else {
                                    self.rotationDirection = .none
                                    self.didSwipe = false
                                }
                            }
                    )
                
                if endedRotation.booleano {
                    Text("AVANÇAR")
                        .font(.footnote)
                        .fontWeight(.light)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, -15)
                }
                
            }
            
            CardView(show: self.$showCards)
                .opacity(self.showCards ? 1 : 0)
        }
    }
}

struct BottleView_Previews: PreviewProvider {
    static var previews: some View {
        BottleView()
    }
}

class GameScene: SKScene {
    
    var bottle: SKSpriteNode = SKSpriteNode(imageNamed: "garrafa")
    
    @Binding var didSwipe: Bool
    @Binding var direction: RotationStatus
    @EnvironmentObject var endedRotation: Boolean
    
    init(didSwipe: Binding<Bool>, direction: Binding<RotationStatus>, endedRotation: EnvironmentObject<Boolean>) {
        self._didSwipe = didSwipe
        self._direction = direction
        self._endedRotation = endedRotation
        super.init(size: CGSize(width: 197, height: 162))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sceneDidLoad() {
        self.backgroundColor = .clear
        bottle.position = CGPoint(x: 100, y: 80)
        bottle.scale(to: CGSize(width: 52, height: 151.77))
        
        self.addChild(bottle)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if direction != .none {
            let randomAngle = Double.random(in: 18.84...37.68)
            let randomDuration = Double.random(in: 4...5)
            let rotateAction = SKAction.rotate(byAngle: (direction == .clockwise) ? -CGFloat(randomAngle) : CGFloat(randomAngle), duration: randomDuration)
            bottle.run(rotateAction)
            direction = .none
        }
        
        if bottle.hasActions() {
            endedRotation.booleano = false
        } else {
            endedRotation.booleano = true
        }
        
    }
}
