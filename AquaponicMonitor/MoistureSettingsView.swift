//
//  moistureSettingsView.swift
//  AquaponicMonitor
//
//  Created by user214468 on 4/18/22.
//

import SwiftUI

struct MoistureSettingsView: View {
    
    @AppStorage("soilMoistureLow") var soilMoistureLow : Double = 0
    @AppStorage("soilMoistureHigh") var soilMoistureHigh : Double = 0
    @EnvironmentObject var model : Model
    
    var body: some View {
        VStack {
            
            ZStack{
                
                HStack{
                    
                    VStack() {
                        
                        Text("Moisture Settings")
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
                        
                        TextField("Lower Bound", value: $soilMoistureLow, formatter: NumberFormatter())
                            .multilineTextAlignment(.center)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .keyboardType(.numberPad)
                        
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
                        
                        TextField("Upper Bound", value: $soilMoistureHigh, formatter: NumberFormatter())
                            .multilineTextAlignment(.center)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .keyboardType(.numberPad)
                        
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
                        
                        Text(String(model.soilMoisture))
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

struct MoistureSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MoistureSettingsView()
    }
}
