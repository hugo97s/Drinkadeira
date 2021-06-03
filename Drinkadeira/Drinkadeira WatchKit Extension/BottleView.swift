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

public enum RotationStatus {
    case clockwise, anticlockwise, none
}

struct BottleView: View {
    @State var startSwipe = false
    @State var endSwipe = false
    @State var rotationDirection: RotationStatus = .none
    @State var showCards = false
    @State var bottleAngle: Double = 0
    private var thresholdPercentage: CGFloat = 0.3
    
    private func getGesturePercentage(_ width: CGFloat, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / width
    }
    
    var body: some View {
        ZStack {
            
            ZStack(alignment: .center){
                SpriteView(scene: GameScene(didSwipe: $startSwipe, direction: $rotationDirection, bottleAngle: $bottleAngle))
                    .opacity(self.showCards ? 0 : 1)
                    .onTapGesture {
                        if endSwipe {
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
                                        self.rotationDirection = .clockwise
                                    }
                                    else{
                                        self.rotationDirection = .anticlockwise
                                    }
                                    
                                    self.startSwipe = true
                                } else if (self.getGesturePercentage(WKInterfaceDevice.current().screenBounds.width, from: value)) <= -self.thresholdPercentage {
                                    if (WKInterfaceDevice.current().screenBounds.height / 2 > value.startLocation.y) {
                                        self.rotationDirection = .anticlockwise
                                    }
                                    else{
                                        self.rotationDirection = .clockwise
                                    }
                                    self.startSwipe = true
                                    
                                } else {
                                    self.rotationDirection = .none
                                    self.startSwipe = false
                                }
                            }
                    )
                    .onChange(of: startSwipe, perform: { value in
                        if value {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
                                print("fim do swipe")
                                endSwipe = true
                            })
                        }
                })
                
                VStack {
                    Spacer()
                    
                    if self.endSwipe {
                        Text("toque para avançar")
                            .font(.footnote)
                            .fontWeight(.light)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, -15)
                            .opacity(self.showCards ? 0: 1)
                    }
                        
                }
            }
        
            CardView(show: self.$showCards, startSwipe: self.$startSwipe, endSwipe: self.$endSwipe)
                .opacity(self.showCards ? 1 : 0)
        }
    }
}

struct GarrafaView_Previews: PreviewProvider {
    static var previews: some View {
        BottleView()
    }
}

class GameScene: SKScene {
    
    var bottle: SKSpriteNode = SKSpriteNode(imageNamed: "garrafa")
    @Binding var startSwipe: Bool
    @Binding var direction: RotationStatus
    @Binding var bottleAngle: Double
    
    init(didSwipe: Binding<Bool>, direction: Binding<RotationStatus>, bottleAngle: Binding<Double>) {
        self._startSwipe = didSwipe
        self._direction = direction
        self._bottleAngle = bottleAngle
        super.init(size: CGSize(width: 197, height: 162))
        //self.bottle.zRotation = CGFloat(self.bottleAngle)

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sceneDidLoad() {
        self.backgroundColor = .clear
        bottle.position = CGPoint(x: 100, y: 80)
        bottle.scale(to: CGSize(width: 52, height: 151.77))
        if bottleAngle != 0 {
            bottle.zRotation = CGFloat(bottleAngle)
            bottleAngle = 0
        }
        self.addChild(bottle)
    }
    
    override func update(_ currentTime: TimeInterval) {
//        if bottleAngle != 0 {
//            self.bottleAngle = 0
//        }
        if direction != .none {
            let randomAngle = Double.random(in: 18.84...37.68)
            let randomDuration = Double.random(in: 4...5)
            let rotateAction = SKAction.rotate(byAngle: (direction == .clockwise) ? -CGFloat(randomAngle) : CGFloat(randomAngle), duration: randomDuration)
            bottle.run(rotateAction){
                print("terminou")
                self.bottleAngle = Double(self.bottle.zRotation)
            }
            direction = .none
            //self.bottleAngle = randomAngle
            print("angulo final da garrafa: ", bottleAngle)
            print("angulo somado a garrafa: ", randomAngle)
            print()
        }
        
//        if !startSwipe {
//            bottleAngle = 0
//        } else if startSwipe && !bottle.hasActions() {
//            let rotateAction = SKAction.rotate(toAngle: CGFloat(bottleAngle), duration: 0)
//            bottle.run(rotateAction)
//
//            print("setar posição final da garrafa")
//        }
        
    }
}
