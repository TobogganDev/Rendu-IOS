//
//  Task.swift
//  cours-swift
//
//  Created by Thomas Doret-Gaïsset on 17/10/2024.
//

import Foundation

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
}
