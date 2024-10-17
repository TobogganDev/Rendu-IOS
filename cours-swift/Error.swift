//
//  Error.swift
//  cours-swift
//
//  Created by Thomas Doret-Gaïsset on 17/10/2024.
//

import Foundation

enum ConnexionError: Error {
    case badLogin
    case badPassword
    
    var title: String {
        switch self {
            case .badLogin:
                return "Login incorrect"
            case .badPassword:
                return "Mot de passe incorrect"
        }
    }
    
    var message: String {
        switch self {
            case .badLogin:
                return "Ce login n'existe pas"
            case .badPassword:
                return "Veuillez saisir un mot de passe valide"
        }
    }
}
