//
//  Model.swift
//  AquaponicMonitor
//
//  Created by user214468 on 4/12/22.
//

import Foundation
import FirebaseDatabase
import Firebase
import UserNotifications
import SwiftUI

class Model : ObservableObject {
    @Published var light : Double
    @Published var liquidLevel : Double
    @Published var soilMoisture : Double
    @Published var pH : Double
    @Published var temperature : Double
    var data : historicData
    
    
                                                      
    init(light: Double, liquidLevel: Double, soilMoisture: Double, pH: Double, temperature: Double) {
        self.light = light
        self.liquidLevel = liquidLevel
        self.soilMoisture = soilMoisture
        self.pH = pH
        self.temperature = temperature
        self.data = historicData(dayOne: historicDataTuple(), dayTwo: historicDataTuple(), dayThree: historicDataTuple(), dayFour: historicDataTuple(), dayFive: historicDataTuple(), daySix: historicDataTuple(), daySeven: historicDataTuple())
    }
    
    
    func readTemperature(path : String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child(path + "/temperature").observe(.childChanged) { snapshot in
            if let temp = snapshot.value as? Double{
                self.temperature = temp
            }
        }
    }
    
    func readLight(path : String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child(path + "/light").observe(.childChanged) { snapshot in
            if let temp = snapshot.value as? Double{
                self.light = temp
            }
        }
    }
    
    func readLiquidLevel(path : String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child(path + "/liquidLevel").observe(.childChanged) { snapshot in
            if let temp = snapshot.value as? Double{
                self.liquidLevel = temp
            }
        }
    }
    
    func readSoilMoisture(path : String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child(path + "/soilMoisture").observe(.childChanged) { snapshot in
            if let temp = snapshot.value as? Double{
                self.soilMoisture = temp
            }
        }
    }
    
    func readPH(path : String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child(path + "/pH").observe(.childChanged) { snapshot in
            if let temp = snapshot.value as? Double{
                self.pH = temp
            }
        }
    }
    
    func populateTemperature(path : String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child(path + "/temperature/value").observeSingleEvent(of: .value, with: {snapshot in
            let value = snapshot.value as? NSNumber
            self.temperature = value?.doubleValue as? Double ?? 420
        }) {error in
            print(error.localizedDescription)
        }
    }
    
    func populateLight(path : String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child(path + "/light/value").observeSingleEvent(of: .value, with: {snapshot in
            let value = snapshot.value as? NSNumber
            self.light = value?.doubleValue as? Double ?? 420
        }) {error in
            print(error.localizedDescription)
        }
    }
    
    func populateLiquidLevel(path : String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child(path + "/liquidLevel/value").observeSingleEvent(of: .value, with: {snapshot in
            let value = snapshot.value as? NSNumber
            self.liquidLevel = value?.doubleValue as? Double ?? 420
        }) {error in
            print(error.localizedDescription)
        }
    }
    
    func populateSoilMoisture(path : String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child(path + "/soilMoisture/value").observeSingleEvent(of: .value, with: {snapshot in
            let value = snapshot.value as? NSNumber
            self.soilMoisture = value?.doubleValue as? Double ?? 420
        }) {error in
            print(error.localizedDescription)
        }
    }
    
    func populatePH(path : String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child(path + "/pH/value").observeSingleEvent(of: .value, with: {snapshot in
            let value = snapshot.value as? NSNumber
            self.pH = value?.doubleValue as? Double ?? 420
        }) {error in
            print(error.localizedDescription)
        }
    }
    func updateValues(path : String) {
        self.readTemperature(path : path)
        self.readLight(path : path)
        self.readPH(path : path)
        self.readLiquidLevel(path : path)
        self.readSoilMoisture(path : path)
        
    }
    
    func populateFields(path : String) {
        self.populateTemperature(path : path)
        self.populateLight(path : path)
        self.populatePH(path : path)
        self.populateLiquidLevel(path : path)
        self.populateSoilMoisture(path : path)
    }
    
    func calculateColor(lowBoundary : Double, highBoundary : Double, value : Double) -> Color {
        if lowBoundary > value {
            return .red
        } else if highBoundary < value {
            return .red
        } else {
            return .green
        }
    }
    
    func calculateLiqLevelColor(value : Double) -> Color {
        if value == 1 {
            return .green
        } else {
            return .red
        }
    }
    struct historicDataTuple {
        var temp : Double
        var li : Double
        var mois : Double
        var pH2 : Double
        var liqLevel : Double
        var time : Int
        
        init() {
            temp = 0
            li = 0
            mois = 0
            pH2 = 0
            liqLevel = 0
            time = 0
        }
    }
    
    struct historicData {
        var dayOne : historicDataTuple
        var dayTwo : historicDataTuple
        var dayThree : historicDataTuple
        var dayFour : historicDataTuple
        var dayFive : historicDataTuple
        var daySix : historicDataTuple
        var daySeven : historicDataTuple
    }
    
    
    func readHistoricalData(path : String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let timeInterval = NSDate().timeIntervalSince1970
        var lightSum : Double = 0
        var liqSum : Double = 0
        var moisSum : Double = 0
        var phSum : Double = 0
        var tempSum : Double = 0
        var time : Int = 0
        time = Int(timeInterval) / 10 * 10
        var time2 : Int = 10900

        // this and the time math determine how far back is queryed 5 * 10 = 50s
        
        for j in 1...7 {
            
            lightSum = 0
            liqSum = 0
            moisSum = 0
            tempSum = 0
            phSum = 0
            
            for i in 1...111 {
                
                ref.child(path + "/historical data/" + String(time2) + "/" + "light").observeSingleEvent(of: .value, with: {snapshot in
                    let datasnap = snapshot.value as? NSNumber ?? 0
                    lightSum = lightSum + Double(datasnap)
                    
                }) { error in
                     print(error.localizedDescription)
                   }
        
                ref.child(path + "/historical data/" + String(time2) + "/" + "temperature").observeSingleEvent(of: .value, with: {snapshot in
                    let datasnap = snapshot.value as? NSNumber ?? 0
                    tempSum = tempSum + Double(datasnap)
                 
                }) { error in
                     print(error.localizedDescription)
                   }
                
                ref.child(path + "/historical data/" + String(time2) + "/" + "liquidLevel").observeSingleEvent(of: .value, with: {snapshot in
                    let datasnap = snapshot.value as? NSNumber ?? 0
                    liqSum = liqSum + Double(datasnap)
               
                }) { error in
                     print(error.localizedDescription)
                   }
                
                ref.child(path + "/historical data/" + String(time2) + "/" + "pH").observeSingleEvent(of: .value, with: {snapshot in
                    let datasnap = snapshot.value as? NSNumber ?? 0
                    phSum = phSum + Double(datasnap)
                
                }) { error in
                     print(error.localizedDescription)
                   }
                
                ref.child(path + "/historical data/" + String(time2) + "/" + "soilMoisture").observeSingleEvent(of: .value, with: {snapshot in
                    let datasnap = snapshot.value as? NSNumber ?? 0
                    moisSum = moisSum + Double(datasnap)
                  
                }) { error in
                     print(error.localizedDescription)
                   }
             
             
                time2 = time2 - 10
            }
            if j == 1 {
                self.data.dayOne.temp = tempSum
                self.data.dayOne.li = lightSum
                self.data.dayOne.liqLevel = liqSum
                self.data.dayOne.mois = moisSum
                self.data.dayOne.pH2 = phSum
            }
            if j == 2 {
                self.data.dayTwo.temp = tempSum
                self.data.dayTwo.li = lightSum
                self.data.dayTwo.liqLevel = liqSum
                self.data.dayTwo.mois = moisSum
                self.data.dayTwo.pH2 = phSum
            }
            if j == 3 {
                self.data.dayThree.temp = tempSum
                self.data.dayThree.li = lightSum
                self.data.dayThree.liqLevel = liqSum
                self.data.dayThree.mois = moisSum
                self.data.dayThree.pH2 = phSum
            }
            if j == 4 {
                self.data.dayFour.temp = tempSum
                self.data.dayFour.li = lightSum
                self.data.dayFour.liqLevel = liqSum
                self.data.dayFour.mois = moisSum
                self.data.dayFour.pH2 = phSum
            }
            if j == 5 {
                self.data.dayFive.temp = tempSum
                self.data.dayFive.li = lightSum
                self.data.dayFive.liqLevel = liqSum
                self.data.dayFive.mois = moisSum
                self.data.dayFive.pH2 = phSum
            }
            if j == 6 {
                self.data.daySix.temp = tempSum
                self.data.daySix.li = lightSum
                self.data.daySix.liqLevel = liqSum
                self.data.daySix.mois = moisSum
                self.data.daySix.pH2 = phSum
            }
            if j == 7 {
                self.data.daySeven.temp = tempSum
                self.data.daySeven.li = lightSum
                self.data.daySeven.liqLevel = liqSum
                self.data.daySeven.mois = moisSum
                self.data.daySeven.pH2 = phSum
            }
        }
    }
    
    func querydb(path : String, time : String, name : String, ref : DatabaseReference!) -> Double {
        print(path + "/historical data/" + time + "/" + name)
        var value : Double
        value = 0
        ref.child(path + "/historical data/" + time + "/" + name).observeSingleEvent(of: .value, with: {snapshot in
            let data = snapshot.value as? NSNumber ?? 0
            value = Double(data)
           }) { error in
             print(error.localizedDescription)
           }
        print(value)
        return value
    }
}
