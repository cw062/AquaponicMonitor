//
//  SettingsView.swift
//  AquaponicMonitor
//
//  Created by user214468 on 4/17/22.
//

import SwiftUI

struct TempSettingsView: View {
    
    
    
    @AppStorage("temperatureLow") var temperatureLow : Double = 0
    @AppStorage("temperatureHigh") var temperatureHigh : Double = 0
    @EnvironmentObject var model: Model
    
    var body: some View {
        
        
        VStack {
            
            ZStack{
                
                HStack{
                    
                    VStack() {
                        
                        Text("Temperature Settings")
                            .font(.title)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)

                    }
                   
                    .padding(50)
                   
                }
                
            }
            .background(.red)
            .cornerRadius(10)
        

            ZStack {
                HStack {
                    VStack {
                        Text("Lower Bound")
                            .font(.title3)
                        
                        TextField("Lower Boundary", text: Binding(
                            get: { String(temperatureLow) },
                            set: { temperatureLow = Double($0) ?? 0 }
                        ))
                        .multilineTextAlignment(.center)
                        .keyboardType(.decimalPad)
                    }
                    .padding()
                    
                }
            }
            .background(.purple)
            .cornerRadius(10)
            
            ZStack {
                HStack {
                    VStack {
                        Text("Upper Bound")
                            .font(.title3)
                        
                        TextField("Upper Boundary", text: Binding(
                            get: { String(temperatureHigh) },
                            set: { temperatureHigh = Double($0) ?? 0 }
                        ))
                        .multilineTextAlignment(.center)
                        .keyboardType(.decimalPad)
                    }
                    .padding()
                    
                }
            }
            .background(.blue)
            .cornerRadius(10)
        
            ZStack {
                HStack {
                    VStack {
                        Text("Current Value")
                            .font(.title3)
                        
                        Text(String(model.temperature))
                        .multilineTextAlignment(.center)

                    }
                    .frame(maxWidth: .infinity, alignment: .center) .padding(30)
                    
                }
            }
            .background(.green)
            .cornerRadius(10)
    }
        
    }
    }

struct TempSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        TempSettingsView()
    }
}
