//
//  AquaponicMonitorApp.swift
//  AquaponicMonitor
//
//  Created by Robert Yarbrough on 4/1/22.
//

import SwiftUI
import Firebase
import UserNotifications

@main
struct AquaponicMonitorApp: App {
    
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
      init() {
           FirebaseApp.configure()

    }

        var body: some Scene {
            WindowGroup {
                let viewModel = AppViewModel()
                let model = Model(light: 0, liquidLevel: 0, soilMoisture: 0, pH: 0, temperature: 0  )
                SignIn()
                    .environmentObject(viewModel)
                    .environmentObject(model)
                    .onAppear() {
                        model.readHistoricalData(path: "0001")
                    }
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
