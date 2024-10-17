//
//  MainView.swift
//  cours-swift
//
//  Created by Thomas Doret-Gaïsset on 15/10/2024.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    
    @State var login: String = ""
    @State var password: String = ""
    @State private var shouldNavigateToMenu = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppParameters.backgroundColor.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Text("Connectez-vous")
                        .font(.title)
                        .foregroundColor(AppParameters.foregroundColor)
                        .padding(.bottom, 20)
                    
                    TextField("Login", text: $login)
                        .frame(width: 246, height: 44)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    SecureField("Password", text: $password)
                        .frame(width: 246, height: 44)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button {
                        viewModel.checkConnection(login: login, password: password)
                        shouldNavigateToMenu = !viewModel.isNotValid
                    } label: {
                        Text("Connexion")
                            .padding()
                            .frame(width: 246, height: 44)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationDestination(isPresented: $shouldNavigateToMenu) {
                MenuAppsView(username: $login)
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text(viewModel.error?.title ?? "Unknown Error"),
                      message: Text(viewModel.error?.message ?? "Unknown Error"))
            }
        }
    }
}

#Preview {
    MainView()
}
