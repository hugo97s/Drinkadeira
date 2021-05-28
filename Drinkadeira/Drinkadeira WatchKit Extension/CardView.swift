//
//  CardView.swift
//  Drinkadeira WatchKit Extension
//
//  Created by Matheus Andrade on 27/05/21.
//

import SwiftUI

struct CardView: View {
    @State var shake: Bool = false
    
    var body: some View {
        VStack(alignment: .center){
            
            MessCardsView(shake: self.$shake)
                .padding(.top)
            
            Text("shake your arm to\ndiscover a card")
                .font(.footnote)
                .fontWeight(.light)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(height: 40)
                .padding(.top, 30)
                .onTapGesture {
                    self.shake.toggle()
                }
                .onReceive(NotificationCenter.default.publisher(for: .deviceDidShake)) { _ in
                    self.shake.toggle()
                }
            
        }
    }
}

struct MessCardsView: View {
    @Binding var shake: Bool
    @State var shakeOffset: [CGFloat] = [0,0,0,0]
    @State var opacity: Double = 1.0
    
    var body: some View {
        ZStack {
            Image("Card")
                .resizable()
                .frame(width: 60, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .rotationEffect(Angle.init(degrees: 45.0))
                .offset(x: shakeOffset[0], y: shakeOffset[0]/2)
            
            Image("Card")
                .resizable()
                .frame(width: 60, height: 80, alignment: .center)
                .rotationEffect(Angle.init(degrees: 15.0))
                .offset(x: shakeOffset[1], y: -shakeOffset[1]/5)
            
            Image("Card")
                .resizable()
                .frame(width: 60, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .rotationEffect(Angle.init(degrees: 350.0))
                .offset(x: shakeOffset[2], y: -shakeOffset[2]/10)
            
            Image("Card")
                .resizable()
                .frame(width: 60, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .rotationEffect(Angle.init(degrees: 320.0))
                .offset(x: shakeOffset[3], y: -shakeOffset[3]/2)
        }
        .opacity(self.opacity)
        .onChange(of: shake, perform: { _ in
            if shake {
                withAnimation(Animation.linear(duration: 1.0)){
                    self.shakeOffset[0] = 50
                    self.shakeOffset[1] = -50
                    self.shakeOffset[2] = 50
                    self.shakeOffset[3] = -50
                    self.opacity = 0.0
                }
            } else {
                withAnimation(Animation.linear(duration: 1.0)){
                    self.shakeOffset[0] = 0
                    self.shakeOffset[1] = 0
                    self.shakeOffset[2] = 0
                    self.shakeOffset[3] = 0
                    self.opacity = 1.0
                }
            }
        })
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
