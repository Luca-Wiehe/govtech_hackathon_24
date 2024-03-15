//
//  govtech_hackathonApp.swift
//  govtech_hackathon
//
//  Created by Luca Wiehe on 14.03.24.
//

import SwiftUI

@main
struct govtech_hackathonApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(NavigationController())
                .environmentObject(TimeManager())
        }
    }
}
