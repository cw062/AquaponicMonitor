//
//  pHSettingsView.swift
//  AquaponicMonitor
//
//  Created by user214468 on 4/18/22.
//

import SwiftUI

struct PHSettingsView: View {
    
    @AppStorage("pHLow") var pHLow : Double = 0
    @AppStorage("pHHigh") var pHHigh : Double = 0
    @EnvironmentObject var model : Model
    
    var body: some View {
        VStack {
            
            ZStack{
                
                HStack{
                    
                    VStack() {
                        
                        Text("pH Settings")
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
                        
                        TextField("Lower Bound", value: $pHLow, formatter: NumberFormatter())
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
                        
                        TextField("Upper Bound", value: $pHHigh, formatter: NumberFormatter())
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
                        
                        Text(String(model.pH))
                        .multilineTextAlignment(.center)

                    }
                    .frame(maxWidth: .infinity, alignment: .center) .padding(30)
                    
                }
            }
            .background(.green)
            .cornerRadius(10)
            
        }    }
}

struct PHSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        PHSettingsView()
    }
}
