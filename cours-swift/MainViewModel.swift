//
//  MainViewModel.swift
//  cours-swift
//
//  Created by Thomas Doret-Gaïsset on 15/10/2024.
//

import Foundation

class MainViewModel: ObservableObject {
    
    @Published var isNotValid = true
    @Published var showAlert = false
    @Published var error: ConnexionError? = nil

    func checkConnection(login: String, password: String) {
        if let realPassword = DataController.registeredUsers[login] {
            if realPassword == password {
                isNotValid = false
                showAlert = false
            } else {
                error = .badPassword
                showAlert = true
            }
        } else {
            error = .badLogin
            showAlert = true
        }
    }
}
