//
//  SignIn.swift
//  AquaponicMonitor
//
//  Created by Robert Yarbrough on 4/12/22.
//

import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject{
    let auth = Auth.auth()
    @Published var signedIn = false
    @AppStorage("ardId") var ardId : String = "placeholder"
    
    var isSignedIn:Bool{
        return auth.currentUser != nil
    }
    
    
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password){[weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            DispatchQueue.main.async{
                self?.signedIn=true
            }
        }
}
    func changeArdId(aid : String) {
        self.ardId = aid
    }
    func signUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password){[weak self] result, error in guard result != nil, error == nil else{
            return
        }
            DispatchQueue.main.async{
                self?.signedIn=true
    }
}
}
    func signOut(){
        try? auth.signOut()
        self.signedIn=false
    }
}
    
struct SignIn: View {
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        NavigationView {
            if viewModel.signedIn{
                ContentView()
            }
            else{
                SignInView()
            }
        }
        .onAppear{viewModel.signedIn = viewModel.isSignedIn
        }
    }
}
struct SignInView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        VStack{
            Image("SignIn")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            VStack{
                TextField("Email Address", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                Button(action: {
                    guard !email.isEmpty, !password.isEmpty else{
                        return
                    }
                    viewModel.signIn(email: email, password: password)
                    
                }, label: {
                    Text("Sign In")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .cornerRadius(8)
                        .background(Color.blue)
                })
                NavigationLink("Create Account", destination: SignUpView())
                    .padding()
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Sign In")
}
}
struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    @State var ardId = ""
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        VStack{
            Image("SignIn")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            VStack{
                TextField("Email Address", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                TextField("Arduino ID", text: $ardId)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                Button(action: {
                    guard !email.isEmpty, !password.isEmpty, !ardId.isEmpty else{
                        return
                    }
                    viewModel.changeArdId(aid: ardId)
                    viewModel.signUp(email: email, password: password)
                }, label: {
                    Text("Create Account")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .cornerRadius(8)
                        .background(Color.blue)
                })
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Create Account")
}
}
struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
            SignIn()
                .preferredColorScheme(.dark)
        }
    }

