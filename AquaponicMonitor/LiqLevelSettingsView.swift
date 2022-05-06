//
//  liqLevelSettingsView.swift
//  AquaponicMonitor
//
//  Created by user214468 on 4/18/22.
//

import SwiftUI

struct LiqLevelSettingsView: View {
    @AppStorage("liquidLevelLow") var liquidLevelLow : Int = 0
    @AppStorage("liquidLevelHigh") var liquidLevelHigh : Int = 0
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct LiqLevelSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        LiqLevelSettingsView()
    }
}
