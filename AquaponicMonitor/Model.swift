//
//  Model.swift
//  AquaponicMonitor
//
//  Created by user214468 on 4/12/22.
//

import Foundation
import FirebaseDatabase
import Firebase

class Model : ObservableObject {
    @Published var light : String
    @Published var liquidLevel : String
    @Published var soilMoisture : String
    @Published var pH : String
    @Published var temperature : String
    let rdb = ReadDatabase(value: "")
    
    init(light: String, liquidLevel: String, soilMoisture: String, pH: String, temperature: String) {
        self.light = light
        self.liquidLevel = liquidLevel
        self.soilMoisture = soilMoisture
        self.pH = pH
        self.temperature = temperature
    }
    
    func readFromDatabase(path: String) -> String {
        var value : String = ""
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child(path).observe(.childChanged) { snapshot in
            if let temp = snapshot.value as? String{
                value = temp
            }
        }
        return value
    }
    
    func updateValues() {
        self.temperature = self.readFromDatabase(path: "temperature")
        print(self.temperature)
    }
    
}
