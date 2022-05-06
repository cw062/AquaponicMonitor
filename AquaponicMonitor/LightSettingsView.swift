//
//  lightSettingsView.swift
//  AquaponicMonitor
//
//  Created by user214468 on 4/18/22.
//

import SwiftUI

struct LightSettingsView: View {
    
    @AppStorage("lightLow") var lightLow : Double = 0
    @AppStorage("lightHigh") var lightHigh : Double = 0
    @EnvironmentObject var model : Model
    
    var body: some View {
        VStack {
            
            ZStack{
                
                HStack{
                    
                    VStack() {
                        
                        Text("Light Settings")
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
                            get: { String(lightLow) },
                            set: { lightLow = Double($0) ?? 0 }
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
                            get: { String(lightHigh) },
                            set: { lightHigh = Double($0) ?? 0 }
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
                        
                        Text(String(model.light))
                        .multilineTextAlignment(.center)

                    }
                    .frame(maxWidth: .infinity, alignment: .center) .padding(30)
                    
                }
            }
            .background(.green)
            .cornerRadius(10)
            
           /* Button(action: { self.showLightSettings = false}) {            ZStack{
                
                HStack{
                    
                    VStack() {
                        
                        Text("Return")
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
            }
            */
        }    }
}

struct LightSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        LightSettingsView()
    }
}
