//
//  SkateSpotterApp.swift
//  SkateSpotter
//
//  Created by Chris Masoud on 7/25/23.
//

import SwiftUI
import FirebaseCore

@main
struct SkateSpotterApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
