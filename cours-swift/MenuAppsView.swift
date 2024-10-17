import SwiftUI

// Component for menu card
struct MenuTile: View {
    let title: String
    let subtitle: String
    let color: Color
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.white)
            }
            Spacer()
            HStack {
                VStack (alignment: .leading, spacing: 3){
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(color)
        .cornerRadius(15)
    }
}

struct MenuAppsView: View {
    @State private var navigateToMusicView = false
    @Binding var username: String
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppParameters.backgroundColor.edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading, spacing: 20) {
                    Text("Hello \(username)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.top)
                    
                    VStack(spacing: 16) {
                        NavigationLink(destination: MusicView()) {
                            MenuTile(title: "Music Player", subtitle: "Techno songs", color: .purple, icon: "headphones")
                                .frame(height: 120)
                        }
                        NavigationLink(destination: TodoView()) {
                            MenuTile(title: "To Do List", subtitle: "Task management", color: .yellow, icon: "text.book.closed.fill")
                                .frame(height: 120)
                        }
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }
}

#Preview {
    MenuAppsView(username: .constant("User"))
}
