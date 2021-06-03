//
//  GotaApp.swift
//  Gota WatchKit Extension
//
//  Created by Hugo Santos on 27/05/21.
//

import SwiftUI

@main
struct GotaApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
