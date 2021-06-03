//
//  CardView.swift
//  Drinkadeira WatchKit Extension
//
//  Created by Matheus Andrade on 27/05/21.
//

import SwiftUI

struct CardView: View {
    @State var shake: Bool = false
    @Binding var show: Bool
    @Binding var startSwipe: Bool
    @Binding var endSwipe: Bool

    var body: some View {
        VStack(alignment: .center){
            
            ZStack {
                ResultCardView(shake: self.$shake)
                    .frame(width: 160, height: 80, alignment: .center)
                
                MessCardsView(shake: self.$shake)
            }
            .onTapGesture {
                if self.shake {
                    self.show = false
                    self.shake = false
                    self.startSwipe = false
                    self.endSwipe = false
                } else {
                    self.shake = true
                }
            }
            .padding(.top)
            
            Spacer()
            
            Text(self.shake ? "toque para sortear o próximo jogador" : "toque para desvendar a ação da carta")
                .font(.system(size: 12))
                .fontWeight(.regular)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.bottom, -18)
                .padding(.horizontal, 15)
                

        }
        .opacity(self.show ? 1 : 0)
    }
}

struct ResultCardView: View {
    @Binding var shake: Bool
    @State var opacity: Double = 0.0
    var card = CardsBank.shared.getRandomCard()
    
    var body: some View {
        VStack {
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                Image(card.getImageName())
                    .resizable()
                    .frame(width: 35, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Spacer().frame(width: 10)
                
                Text(card.getName())
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
            }
            
            
            Text(card.getDescription())
                .font(.system(size: 13))
                .fontWeight(.regular)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .frame(height: 50)
                .padding(.top, 2)
            
        }
        .shadow(radius: 10)
        .padding(.horizontal, 1)
        .padding()
        .onChange(of: shake, perform: { _ in
            if shake {
                withAnimation(Animation.linear(duration: 1.0)){
                    self.opacity = 1.0
                }
            } else {
                self.opacity = 0.0
            }
        })
        .background(Color.init(UIColor.init(red: 121/255, green: 195/255, blue: 244/255, alpha: 1.0))) // RGB(137, 180, 209)
        .cornerRadius(10)
        .opacity(self.opacity)
        .offset(y: 15)
    }
}

struct MessCardsView: View {
    @Binding var shake: Bool
    @State var shakeOffset: [CGFloat] = [0,0,0,0]
    @State var opacity: Double = 1.0
    let cardImageName = "CardBack"
    
    var body: some View {
        ZStack {
            Image(cardImageName)
                .resizable()
                .frame(width: 60, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .rotationEffect(Angle.init(degrees: 45.0))
                .offset(x: shakeOffset[0], y: shakeOffset[0]/2)
            
            Image(cardImageName)
                .resizable()
                .frame(width: 60, height: 80, alignment: .center)
                .rotationEffect(Angle.init(degrees: 15.0))
                .offset(x: shakeOffset[1], y: -shakeOffset[1]/5)
            
            Image(cardImageName)
                .resizable()
                .frame(width: 60, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .rotationEffect(Angle.init(degrees: 350.0))
                .offset(x: shakeOffset[2], y: -shakeOffset[2]/10)
            
            Image(cardImageName)
                .resizable()
                .frame(width: 60, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .rotationEffect(Angle.init(degrees: 320.0))
                .offset(x: shakeOffset[3], y: -shakeOffset[3]/2)
        }
        .offset(y: 10)
        .opacity(self.opacity)
        .onChange(of: shake, perform: { _ in
            if shake {
                withAnimation(Animation.linear(duration: 0.5)){
                    self.shakeOffset[0] = 50
                    self.shakeOffset[1] = -50
                    self.shakeOffset[2] = 50
                    self.shakeOffset[3] = -50
                    self.opacity = 0.0
                }
            } else {
                self.shakeOffset[0] = 0
                self.shakeOffset[1] = 0
                self.shakeOffset[2] = 0
                self.shakeOffset[3] = 0
                self.opacity = 1.0
            }
        })
    }
}

struct CardView_Previews: PreviewProvider {
    
    static var previews: some View {
        CardView(shake: false, show: .constant(true), startSwipe: .constant(true), endSwipe: .constant(true))
    }
}
