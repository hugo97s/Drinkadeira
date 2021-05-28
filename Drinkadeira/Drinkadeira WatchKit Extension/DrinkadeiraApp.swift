//
//  DrinkadeiraApp.swift
//  Drinkadeira WatchKit Extension
//
//  Created by Hugo Santos on 27/05/21.
//

import SwiftUI

@main
struct DrinkadeiraApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                CardView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
