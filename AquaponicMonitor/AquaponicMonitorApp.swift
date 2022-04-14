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
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
      init() {
           FirebaseApp.configure()

    }

        var body: some Scene {
            WindowGroup {
                let viewModel = AppViewModel()
                SignIn()
                    .environmentObject(viewModel)
            }
        }
    }

    class AppDelegate: NSObject, UIApplicationDelegate{
        func applicationDidFinishLaunching(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
                                           [UIApplication.LaunchOptionsKey : Any]? = nil)->Bool {
            FirebaseApp.configure()

            return true
        }
    }
