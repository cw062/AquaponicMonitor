//
//  SettingsModel.swift
//  AquaponicMonitor
//
//  Created by user214468 on 4/14/22.
//

import Foundation
import Combine

class SettingsModel : ObservableObject {
    @Published var lowBoundary : Int {
        didSet {
            UserDefaults.standard.set(lowBoundary, forKey: "lowBoundary")
        }
    }
    
    init() {
        self.lowBoundary = UserDefaults.standard.integer(forKey: "username")
    }
    
    
}
