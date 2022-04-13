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
    
    func readTemperature() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("temperature").observe(.childChanged) { snapshot in
            if let temp = snapshot.value as? String{
                self.temperature = temp
            }
        }
    }
    
    func readLight() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("light").observe(.childChanged) { snapshot in
            if let temp = snapshot.value as? String{
                self.light = temp
            }
        }
    }
    
    func readLiquidLevel() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("liquidLevel").observe(.childChanged) { snapshot in
            if let temp = snapshot.value as? String{
                self.liquidLevel = temp
            }
        }
    }
    
    func readSoilMoisture() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("soilMoisture").observe(.childChanged) { snapshot in
            if let temp = snapshot.value as? String{
                self.soilMoisture = temp
            }
        }
    }
    
    func readPH() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("pH").observe(.childChanged) { snapshot in
            if let temp = snapshot.value as? String{
                self.pH = temp
            }
        }
    }
    
    func populateTemperature() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("temperature/value").getData(completion: { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            self.temperature = snapshot.value as? String ?? "idk"
        });
    }
    
    func populateLight() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("light/value").getData(completion: { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            self.light = snapshot.value as? String ?? "idk"
        });
    }
    
    func populateLiquidLevel() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("liquidLevel/value").getData(completion: { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            self.liquidLevel = snapshot.value as? String ?? "idk"
        });
    }
    
    func populateSoilMoisture() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("soilMoisture/value").getData(completion: { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            self.soilMoisture = snapshot.value as? String ?? "idk"
        });
    }
    
    func populatePH() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("pH/value").getData(completion: { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            self.pH = snapshot.value as? String ?? "idk"
        });
    }
    func updateValues() {
        self.readTemperature()
        self.readLight()
        self.readPH()
        self.readLiquidLevel()
        self.readSoilMoisture()
        
    }
    
    func populateFields() {
        self.populateTemperature()
        self.populateLight()
        self.populatePH()
        self.populateLiquidLevel()
        self.populateSoilMoisture()
    }
    
}
