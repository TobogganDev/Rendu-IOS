import AVFoundation
import SwiftUI

struct MusicView: View {
    @StateObject private var viewModel = MusicViewModel()
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isPlaying: Bool = false
    @State private var currentSongIndex: Int = 0
    @State private var currentTime: TimeInterval = 0
    @State private var totalDuration: TimeInterval = 0
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
            ZStack {
                AppParameters.backgroundColor.edgesIgnoringSafeArea(.all)
                
                VStack {
                    List(viewModel.music.indices, id: \.self) { index in
                        let song = viewModel.music[index]
                        HStack {
                            Image(song.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                            VStack(alignment: .leading) {
                                Text(song.name)
                                    .foregroundColor(AppParameters.foregroundColor)
                                Text(song.artist)
                                    .font(.subheadline)
                                    .foregroundColor(AppParameters.foregroundColor.opacity(0.7))
                            }
                            Spacer()
                            Button(action: {
                                playSong(at: index)
                            }) {
                                Image(systemName: currentSongIndex == index && isPlaying ? "pause.circle" : "play.circle")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .foregroundColor(AppParameters.foregroundColor)
                            }
                        }
                        .listRowBackground(AppParameters.backgroundColor)
                    }
                    .listStyle(PlainListStyle())
                    
                    // Playback controls and progress bar
                    VStack {
                        if let currentSong = viewModel.music[safe: currentSongIndex] {
                            Text(currentSong.name)
                                .font(.headline)
                                .foregroundColor(AppParameters.foregroundColor)
                            Text(currentSong.artist)
                                .font(.subheadline)
                                .foregroundColor(AppParameters.foregroundColor.opacity(0.7))
                        }
                        
                        // Progress bar
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .fill(AppParameters.foregroundColor.opacity(0.3))
                                    .frame(height: 4)
                                
                                Rectangle()
                                    .fill(AppParameters.foregroundColor)
                                    .frame(width: geometry.size.width * CGFloat(currentTime / totalDuration), height: 4)
                            }
                            .gesture(DragGesture(minimumDistance: 0)
                                .onChanged({ value in
                                    seek(value: value, in: geometry)
                                }))
                        }
                        .frame(height: 4)
                        
                        // Time labels
                        HStack {
                            Text(formatTime(currentTime))
                            Spacer()
                            Text(formatTime(totalDuration))
                        }
                        .font(.caption)
                        .foregroundColor(AppParameters.foregroundColor)
                        
                        HStack {
                            Button(action: previousSong) {
                                Image(systemName: "backward.fill")
                                    .foregroundColor(AppParameters.foregroundColor)
                            }
                            .disabled(currentSongIndex == 0)
                            
                            Button(action: togglePlayPause) {
                                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(AppParameters.foregroundColor)
                            }
                            
                            Button(action: nextSong) {
                                Image(systemName: "forward.fill")
                                    .foregroundColor(AppParameters.foregroundColor)
                            }
                            .disabled(currentSongIndex == viewModel.music.count - 1)
                        }
                        .padding()
                    }
                    .padding()
                    .background(Color.black.opacity(0.5))
                }
            }
            .onAppear {
                viewModel.loadSongs()
                setupAudioSession()
            }
            .onReceive(timer) { _ in
                updateProgress()
            }
        }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session category: \(error)")
        }
    }
    
    private func playSong(at index: Int) {
        stopCurrentAudio()
        currentSongIndex = index
        if let song = viewModel.music[safe: index] {
            playSound(fileName: song.filePath)
        }
    }
    
    private func playSound(fileName: String) {
        let fileNameWithoutExtension = (fileName as NSString).deletingPathExtension
        let fileExtension = (fileName as NSString).pathExtension
        
        guard let soundURL = Bundle.main.url(forResource: fileNameWithoutExtension, withExtension: fileExtension) else {
            print("Unable to find \(fileName) in bundle")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            isPlaying = true
            totalDuration = audioPlayer?.duration ?? 0
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    private func stopCurrentAudio() {
        audioPlayer?.stop()
        audioPlayer = nil
        isPlaying = false
        currentTime = 0
        totalDuration = 0
    }
    
    private func togglePlayPause() {
        if isPlaying {
            audioPlayer?.pause()
            isPlaying = false
        } else {
            audioPlayer?.play()
            isPlaying = true
        }
    }
    
    private func nextSong() {
        if currentSongIndex < viewModel.music.count - 1 {
            playSong(at: currentSongIndex + 1)
        }
    }
    
    private func previousSong() {
        if currentSongIndex > 0 {
            playSong(at: currentSongIndex - 1)
        }
    }
    
    private func updateProgress() {
        guard let player = audioPlayer, player.isPlaying else { return }
        currentTime = player.currentTime
    }
    
    private func seek(value: DragGesture.Value, in geometry: GeometryProxy) {
        guard let player = audioPlayer, totalDuration > 0 else { return }
        let percentage = min(max(0, Double(value.location.x / geometry.size.width)), 1)
        player.currentTime = totalDuration * percentage
        currentTime = player.currentTime
    }
    
    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    MusicView()
}
