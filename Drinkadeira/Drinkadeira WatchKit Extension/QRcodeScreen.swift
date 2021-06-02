//
//  QRcodeScreen.swift
//  Drinkadeira WatchKit Extension
//
//  Created by Hugo Santos on 31/05/21.
//

import SwiftUI

struct QRcodeScreen: View {
    var body: some View {
        VStack(alignment: .center, spacing: nil){
            Image("QRcodeRules")
                        .resizable()
                        .scaledToFit()
        }
    }


struct QRcodeScreen_Previews: PreviewProvider {
    static var previews: some View {
        QRcodeScreen()
    }
}
}
