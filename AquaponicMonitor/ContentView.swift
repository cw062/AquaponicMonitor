import SwiftUI
import Combine

struct ContentView: View {
    
    var body: some View {
        
        NavigationView{
            Home()
                .preferredColorScheme(.light)
                .navigationTitle("My Aquaponics Monitor")
                .navigationBarHidden(true)
                .navigationBarTitleDisplayMode(.inline)
                        
                
            
        }
            .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
    @Namespace var animation
    
    
    @State var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @EnvironmentObject var viewModel: AppViewModel
    @EnvironmentObject var model : Model
    @AppStorage("soilMoistureLow") var soilMoistureLow : Double = 0
    @AppStorage("soilMoistureHigh") var soilMoistureHigh : Double = 0
    @AppStorage("temperatureLow") var temperatureLow : Double = 0
    @AppStorage("temperatureHigh") var temperatureHigh : Double = 0
    @AppStorage("lightLow") var lightLow : Double = 0
    @AppStorage("lightHigh") var lightHigh : Double = 0
    @AppStorage("pHLow") var pHLow : Double = 0
    @AppStorage("pHHigh") var pHHigh : Double = 0
    @State var historicData = [
           
               HistoricalData(day: Calendar.current.date(byAdding: .day, value: -6, to: Date())!, value: 20, show: true),
               HistoricalData(day: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, value: 60, show: false),
               HistoricalData(day: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, value: 30, show: false),
               HistoricalData(day: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, value: 50, show: false),
               HistoricalData(day: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, value: 40, show: false),
               HistoricalData(day: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, value: 70, show: false),
               HistoricalData(day: Date(), value: 4, show: false)
       ]
    

    
    var body: some View {
    
        NavigationView{
            VStack{
                
                HStack{
                    
                    Button(action: {model.populateFields(path: viewModel.ardId)}) {
                        
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .renderingMode(.template)
                            .foregroundColor(.white)
                    }
                    
                    Spacer(minLength: 0)
                    
                    NavigationLink( destination: SettingsPage().environmentObject(viewModel)) {
                        
                        Image("menu")
                            .renderingMode(.template)
                            .foregroundColor(.white)
                    }
                }
                .padding()
            

                
                // Or YOu can use Foreach Also...
                    VStack(spacing: 10){
                        
                        HStack(spacing: 15){
                            
                            NavigationLink(destination: TempSettingsView().environmentObject(model)) {
                                SalesView(sale: Sales(title: "Temperature", value: model.temperature, color: model.calculateColor(lowBoundary: temperatureLow, highBoundary: temperatureHigh, value: model.temperature)))
                            }
                            .navigationBarHidden(true)
                            .navigationBarTitleDisplayMode(.inline)
                            
                            NavigationLink(destination: PHSettingsView().environmentObject(model)) {
                                SalesView(sale: Sales(title: "pH", value: model.pH, color: model.calculateColor(lowBoundary: pHLow, highBoundary: pHHigh, value: model.pH)))
                            }
                            .navigationBarHidden(true)
                            .navigationBarTitleDisplayMode(.inline)
                            
                        }
                        
                        HStack(spacing: 15){
                            
                            NavigationLink(destination: MoistureSettingsView().environmentObject(model)) {
                                SalesView(sale: Sales(title: "Moisture", value: model.soilMoisture, color: model.calculateColor(lowBoundary: soilMoistureLow, highBoundary: soilMoistureHigh, value: model.soilMoisture)))
                            }
                            
                                SalesView(sale: Sales(title: "Water Level", value: model.liquidLevel, color: model.calculateLiqLevelColor(value: model.liquidLevel)))
                           

                            NavigationLink(destination: LightSettingsView().environmentObject(model)) {
                                SalesView(sale: Sales(title: "Light", value: model.light, color: model.calculateColor(lowBoundary: lightLow, highBoundary: lightHigh, value: model.light)))
                            }
                            .navigationBarHidden(true)
                            .navigationBarTitleDisplayMode(.inline)
                            
                        }
                    }
                    .padding(.horizontal)
                    .onAppear() {
                        self.model.populateFields(path : viewModel.ardId)
                        self.model.updateValues(path : viewModel.ardId)
                    }
                
                    ZStack{
                    
                        Color.white
                            .clipShape(CustomCorners(corners: [.topLeft,.topRight], size: 45))
                            .ignoresSafeArea(.all, edges: .bottom)
                        
                        VStack{
                            
                            HStack{
                                
                                Text("Historical Data")
                                    .font(.title2)
                                    .foregroundColor(.black)
                                    .frame(width: 300, height: 20, alignment: .center)
                                
                                Spacer(minLength: 0)
                            }
                            .padding(.bottom, 5)
                            .padding(.top,10)
                            
                            HStack (spacing: 10){
                                Button("Light", action: {
                                    historicData = [
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -6, to: Date())!, value: self.model.data.daySeven.li, show: true),
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, value: self.model.data.daySix.li, show: false),
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, value: self.model.data.dayFive.li, show: false),
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, value: self.model.data.dayFour.li, show: false),
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, value: self.model.data.dayThree.li, show: false),
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, value: self.model.data.dayTwo.li, show: false),
                                        HistoricalData(day: Date(), value: self.model.data.dayOne.li, show: false)]})
                                Button("Moisture", action: {
                                    historicData = [
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -6, to: Date())!, value: self.model.data.daySeven.mois, show: true),
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, value: self.model.data.daySix.mois, show: false),
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, value: self.model.data.dayFive.mois, show: false),
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, value: self.model.data.dayFour.mois, show: false),
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, value: self.model.data.dayThree.mois, show: false),
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, value: self.model.data.dayTwo.mois, show: false),
                                        HistoricalData(day: Date(), value: self.model.data.dayOne.mois, show: false)]})
                                                            
                                Button("Temperature", action: {
                                    historicData = [
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -6, to: Date())!, value: self.model.data.daySeven.temp, show: true),
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, value: self.model.data.daySix.temp, show: false),
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, value: self.model.data.dayFive.temp, show: false),
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, value: self.model.data.dayFour.temp, show: false),
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, value: self.model.data.dayThree.temp, show: false),
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, value: self.model.data.dayTwo.temp, show: false),
                                        HistoricalData(day: Date(), value: self.model.data.dayOne.temp, show: false)]})
                                Button("pH", action: {
                                    historicData = [
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -6, to: Date())!, value: self.model.data.daySeven.pH2, show: true),
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, value: self.model.data.daySix.pH2, show: false),
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, value: self.model.data.dayFive.pH2, show: false),
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, value: self.model.data.dayFour.pH2, show: false),
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, value: self.model.data.dayThree.pH2, show: false),
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, value: self.model.data.dayTwo.pH2, show: false),
                                        HistoricalData(day: Date(), value: self.model.data.dayOne.pH2, show: false)]})
                                Button("Liquid Level", action: {
                                    historicData = [
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -6, to: Date())!, value: self.model.data.daySeven.liqLevel, show: true),
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, value: self.model.data.daySix.liqLevel, show: false),
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, value: self.model.data.dayFive.liqLevel, show: false),
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, value: self.model.data.dayFour.liqLevel, show: false),
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, value: self.model.data.dayThree.liqLevel, show: false),
                                        HistoricalData(day: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, value: self.model.data.dayTwo.liqLevel, show: false),
                                        HistoricalData(day: Date(), value: self.model.data.dayOne.liqLevel, show: false)]})
                                                            
                                }
                            HStack(spacing: 10) {
                                ForEach(historicData.indices,id: \.self){i in
                                    
                                    
                                    GraphView(data: historicData[i], allData: historicData)
                                        .onTapGesture {
                                            
                                            withAnimation{
                                                
                                                // toggling all other...
                                                
                                                for index in 0..<historicData.count{
                                                    
                                                    historicData[index].show = false
                                                }
                                                
                                                historicData[i].show.toggle()
                                            }
                                        }
                                    
                                    
                                    if historicData[i].value != historicData.last!.value{
                                        
                                        Spacer(minLength: 0)
                                    }
                                }
                            }
                            .padding(.horizontal,30)
                            .padding(.bottom,edges!.bottom == 0 ? 15 : 0)
                            .onAppear() {
                                self.model.readHistoricalData(path: String(self.viewModel.ardId))
                            }
                    }
                    .padding(.top,20)
                }
            }
            .background(Color("bg").ignoresSafeArea(.all, edges: .all))
        }
        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
}
struct Sales : Identifiable {
    
    var id = UUID().uuidString
    var title : String
    var value : Double
    var color : Color
}

struct historicDataTuple {
    var temperature : Double = 0
    var light : Double = 0
    var moisture : Double = 0
    var pH : Double = 0
    var liqLevel : Double = 0
    var time : Int = 0

}


struct HistoricalData : Identifiable {
    var id = UUID().uuidString
    var day : Date
    var value : Double
    var show : Bool
}

struct SalesView : View {
    var sale : Sales
    
    var body: some View{
        ZStack{
            
            HStack{
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text(sale.title)
                        .foregroundColor(.white)
                    
                    Text(String(sale.value))
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            
                Spacer(minLength: 0)
            }
            .padding()
        }
        .background(sale.color)
        .cornerRadius(10)
        
    }
        
}




struct CustomCorners : Shape {
    
    var corners : UIRectCorner
    var size : CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: size, height: size))
        
        return Path(path.cgPath)
    }
}

struct GraphView : View {
    
    var data : HistoricalData
    var allData : [HistoricalData]
    
    var body: some View{
        
        VStack(spacing: 5){
            
            GeometryReader{reader in
                
                VStack(spacing: 0){
                    
                    Spacer(minLength: 0)
                    
                    Text("\(data.value)")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        // default Height For Graph...
                        .frame(height: 20)
                        .opacity(data.show ? 1 : 0)
                    
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.red.opacity(data.show ? 1 : 0.4))
                        .frame(height: calulateHeight(value: data.value, height: reader.frame(in: .global).height - 20))
                }
            }
            
            Text(customDateStyle(date: data.day))
                .font(.caption2)
                .foregroundColor(.gray)
        }
    }
    
    func customDateStyle(date: Date)->String{
        
        let format = DateFormatter()
        format.dateFormat = "MMM dd"
        return format.string(from: date)
    }
    
    func calulateHeight(value: Double,height: CGFloat)->CGFloat{
        
        let max = allData.max { (max, sale) -> Bool in
            
            if max.value > sale.value{return false}
            else{return true}
        }
        
        let percent = value / max!.value
        
        return percent * height
    }
}
