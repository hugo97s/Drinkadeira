//
//  ContentView.swift
//  Drinkadeira WatchKit Extension
//
//  Created by Hugo Santos on 27/05/21.
//

import SwiftUI

class Boolean: ObservableObject {
    var booleano = false
    
    init() {
        self.booleano = false
    }
}

struct ContentView: View {
    @State private var showDetails = false
    var teste: Boolean = Boolean()
    
    var body: some View {
        VStack(alignment: .center, spacing:20){
            Image("Gota")
                        .resizable()
                        .scaledToFit()
                
            HStack(alignment: .top, spacing: 15){
                NavigationLink(destination: BottleView().environmentObject(teste)) {
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
