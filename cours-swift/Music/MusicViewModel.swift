//
//  MusicViewModel.swift
//  cours-swift
//
//  Created by Thomas Doret-Gaïsset on 17/10/2024.
//

import Foundation

class MusicViewModel: ObservableObject {
    @Published var music: [Song] = []
    
    init() {
        loadSongs()
    }
    
    func loadSongs() {
        let song1 = Song(name: "Dance All Night", artist: "Dave 75", image: "dance-all-night", filePath: "dance-all-night.wav")
        let song2 = Song(name: "Flower Flip", artist: "Rin la Dalle", image: "flower-flip", filePath: "flower-flip.wav")
        let song3 = Song(name: "Rara Vez", artist: "MSKD vs Dj Unknown One", image: "rara-vez", filePath: "rara-vez.wav")
        // Assigning the list of songs
        music = [song1, song2, song3]
    }
}

