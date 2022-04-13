import SwiftUI


struct ContentView: View {
    var body: some View {

        NavigationView{
            
            Home()
                .preferredColorScheme(.dark)
                .navigationTitle("")
                .navigationBarHidden(true)
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
    @State var historicData = [
        
            HistoricalData(day: Calendar.current.date(byAdding: .day, value: -6, to: Date())!, value: 200, show: true),
            HistoricalData(day: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, value: 710, show: false),
            HistoricalData(day: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, value: 330, show: false),
            HistoricalData(day: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, value: 519, show: false),
            HistoricalData(day: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, value: 150, show: false),
            HistoricalData(day: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, value: 229, show: false),
            HistoricalData(day: Date(), value: 669, show: false)
    ]
    
    @State var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @StateObject var model = Model(light: "0", liquidLevel: "0", soilMoisture: "0", pH: "0", temperature: "0")
    
    var body: some View {
        
        VStack{
            
            HStack{
                
                Button(action: {}) {
                    
                    Image("menu")
                        .renderingMode(.template)
                        .foregroundColor(.white)
                }
                
                Spacer(minLength: 0)
                
                Button(action: {}) {
                    
                    Image("bell")
                        .renderingMode(.template)
                        .foregroundColor(.white)
                }
            }
            .padding()
                    
            HStack{
                
                Text("AquaponicsMonitor")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer(minLength: 0)
            }
            .padding()
            .background(Color.white.opacity(0.08))
            .clipShape(Capsule())
            .padding(.horizontal)
            

            
            // Or YOu can use Foreach Also...
            VStack(spacing: 20){
                
                HStack(spacing: 15){
                    
                   // var salesData = [
                    SalesView(sale: Sales(title: "Temperature", value: model.temperature, color: Color.red))
                    SalesView(sale: Sales(title: "pH", value: model.pH, color: Color.green))
                        //Sales(title: "Soil Moisture", value: "8,500", color: Color.gray),
                        //Sales(title: "Water Level", value: "2,000", color: Color.blue),
                       // Sales(title: "Light", value: light, color: Color.yellow),
                    //]
                }
                
                HStack(spacing: 15){
                    
                    SalesView(sale: Sales(title: "Soil Moisture", value: model.soilMoisture, color: Color.gray))
                    
                    SalesView(sale: Sales(title: "Water Level", value: model.liquidLevel, color: Color.blue))
                    
                    SalesView(sale: Sales(title: "Light", value: model.light, color: Color.yellow))
                }
            }
            .padding(.horizontal)
            .onAppear() {
                self.model.populateFields()
                self.model.updateValues()
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
                        
                        Spacer(minLength: 0)
                    }
                    .padding()
                    .padding(.top,10)
                    
                    HStack(spacing: 10){
                        
                        ForEach(historicData.indices,id: \.self){i in
                            
                            // For Toggling Show Button....
                            
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
                            
                            // sample Sapcing For Spacing Effect..
                            
                            if historicData[i].value != historicData.last!.value{
                                
                                Spacer(minLength: 0)
                            }
                        }
                    }
                    .padding(.horizontal,30)
                    .padding(.bottom,edges!.bottom == 0 ? 15 : 0)
                }
            }
            .padding(.top,20)
        }
        .background(Color("bg").ignoresSafeArea(.all, edges: .all))
    }
   
}
                              
struct Sales : Identifiable {
    
    var id = UUID().uuidString
    var title : String
    var value : String
    var color : Color
}
                              


// Daily Sold Model And Data....

struct HistoricalData : Identifiable {
    var id = UUID().uuidString
    var day : Date
    var value : CGFloat
    var show : Bool
}

struct SalesView : View {
    
    var sale : Sales
    
    var body: some View{
        
        ZStack{
            
            HStack{
                
                VStack(alignment: .leading, spacing: 22) {
                    
                    Text(sale.title)
                        .foregroundColor(.white)
                    
                    Text(sale.value)
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
                    
                    Text("\(Int(data.value))")
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
    
    func calulateHeight(value: CGFloat,height: CGFloat)->CGFloat{
        
        let max = allData.max { (max, sale) -> Bool in
            
            if max.value > sale.value{return false}
            else{return true}
        }
        
        let percent = value / max!.value
        
        return percent * height
    }
}
