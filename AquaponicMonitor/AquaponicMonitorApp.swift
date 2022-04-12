//
//  AquaponicMonitorApp.swift
//  AquaponicMonitor
//
//  Created by Robert Yarbrough on 4/1/22.
//

import SwiftUI
import Firebase

@main
struct AquaponicMonitorApp: App {
    
    init() {
        FirebaseApp.configure()
    
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
