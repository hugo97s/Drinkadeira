//
//  ContentView.swift
//  Drinkadeira WatchKit Extension
//
//  Created by Hugo Santos on 27/05/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showDetails = false
    var body: some View {
        VStack(alignment: .center, spacing:20){
            Image("Gota")
                        .resizable()
                        .scaledToFit()
                
            HStack(alignment: .top, spacing: 15){
                NavigationLink(destination: CardView()) {
                                    Text("Jogar")
                }
                NavigationLink(destination: QRcodeScreen()) {
                                    Text(" Regras")
                }
            }
            .padding(.bottom, -35)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
