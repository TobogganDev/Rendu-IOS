//
//  Song.swift
//  cours-swift
//
//  Created by Thomas Doret-Gaïsset on 17/10/2024.
//

import Foundation

struct Song: Identifiable {
    let id = UUID()
    let name: String
    let artist: String
    let image: String
    let filePath: String // Path to the audio file
}
