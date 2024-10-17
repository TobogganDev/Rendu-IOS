//
//  DataController.swift
//  cours-swift
//
//  Created by Thomas Doret-Gaïsset on 15/10/2024.
//

import Foundation

class DataController {
    static let shared = DataController()
    static let registeredUsers: [String: String] = [
        "Thomas": "123",
        "paul": "456"
    ]
}
