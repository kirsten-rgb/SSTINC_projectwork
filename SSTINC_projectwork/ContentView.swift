//
//  ContentView.swift
//  SSTINC_projectwork
//
//  Created by Kirsten Petros on 1/9/25.
//

import SwiftUI

// MARK: - GameState
class GameState: ObservableObject {
    @Published var currentStage: Stage = .start
    @Published var clues: [String] = []
    @Published var interrogated: Set<String> = []
    @Published var gatheredClues: Set<String> = [] // suspects whose clues have been gathered
    @Published var showSolveButton: Bool = false
    @Published var showGatherButton: Bool = false
    @Published var finalMessage: String? = nil
    
    enum Stage {
        case start
        case suspects
        case clueSharing(String)   // <-- new stage
        case interrogation(String)
        case gather
        case final
    }
    
    let suspects: [String: String] = [
        "Obama": "🕶️",
        "Joshua": "🧑‍💼",
        "Kesler": "👨‍🔧",
        "Elon Musk": "🚀",
        "Bill Gates": "💻",
        "Taylor Swift": "🎤"
    ]
    
    func clueFor(suspect: String) -> String {
        switch suspect {
        case "Obama":
            return "(Obama) I was counting cash in my hotel room, listening to the sweet sounds and music of America. I couldn't hear anything from the outside at all."
        case "Joshua":
            return "(Joshua) I was downstairs chiling in the lobby eating some snacks."
        case "Kesler":
            return "(Kesler) I was on my way back to the hotel from buying groceries "
        case "Elon Musk":
            return "(Elon Musk) I was on my way to the bank to pay a bet I lost to Taylor."
        case "Bill Gates":
            return "(Bill Gates) I was getting coffee to focus on sleeping."
        case "Taylor Swift":
            return "(Taylor Swift)  I was outside on a late-night walk while waiting for Elon to get me my money. My bodyguards were with me, I’m innocent!"
        default:
            return "(Unknown) No clue."
        }
    }
    
    // NEW: separate "clue each suspect found"
    func foundClueFor(suspect: String) -> String {
        switch suspect {
        case "Obama":
            return "(Obama) I was counting cash in my hotel room, listening to the sweet sounds and music of America. I couldn't hear anything from the outside at all."
                    case "Joshua":
                        return "(Joshua) I noticed gloves in the trash bin of the hotel, and some distant humming of a familiar patriotic tune. The thief had probably just left the scene inside the hotel. 😦"
                    case "Kesler":
                        return "(Kesler)  I was on my way back to the hotel from buying groceries and saw a figure lurking about, maybe after a break-up? I heard something about bad blood. 😐"
                    case "Elon Musk":
                        return "(Elon Musk) Saw someone passing me by in the hallway while I was on my way to the bank. They were humming something… could’ve been a song from the radio? It reminded me of a national tune."
                    case "Bill Gates":
                        return "(Bill Gates) I was getting coffee to focus on sleeping when I saw Obama passing by, and when I went further into the hotel I saw Joshua staring into the trash. 😥"
                    case "Taylor Swift":
                        return "(Taylor Swift) I was outside on a late-night walk. Saw Kesler passing me by back to the hotel with some grocery bags some weird black limousine waiting outside. Maybe it was a get-away car? Didn't seem to work though, maybe the suspect was being watched."
        default:
            return "(Unknown) No clue."
        }
    }
    
    func allInterrogated() -> Bool {
        return interrogated.count == suspects.count
    }
    
    func backgroundColor(for suspect: String) -> Color {
        switch suspect {
        case "Obama": return Color.red.opacity(0.4)
        case "Joshua": return Color.blue.opacity(0.4)
        case "Kesler": return Color.green.opacity(0.4)
        case "Elon Musk": return Color.purple.opacity(0.4)
        case "Bill Gates": return Color.yellow.opacity(0.4)
        case "Taylor Swift": return Color.pink.opacity(0.4)
        default: return Color.gray.opacity(0.4)
        }
    }
}

// MARK: - ContentView
struct ContentView: View {
    @StateObject private var gameState = GameState()
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.black, Color.gray.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            switch gameState.currentStage {
            case .start:
                StartView(gameState: gameState)
            case .suspects:
                SuspectListView(gameState: gameState)
            case .clueSharing(let suspect):
                ClueSharingView(gameState: gameState, suspect: suspect)
            case .interrogation(let suspect):
                InterrogationView(gameState: gameState, suspect: suspect)
            case .gather:
                GatherView(gameState: gameState)
            case .final:
                FinalRevealView(gameState: gameState)
            }
        }
    }
}

// MARK: - StartView
struct StartView: View {
    @ObservedObject var gameState: GameState
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            Text("🕵️‍♂️ The Incoin Heist")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
            
            Text("The world’s first digital currency, Incoin, has been stolen overnight. Your mission: ask suspects for clues, interrogate them, gather all evidence, and reveal the culprit before they escape!")
                .multilineTextAlignment(.center)
                .foregroundColor(.white.opacity(0.9))
                .padding()
                .background(RoundedRectangle(cornerRadius: 15).fill(Color.black.opacity(0.5)))
                .padding(.horizontal)
            
            Button("Begin Investigation") {
                gameState.currentStage = .suspects
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
    }
}

// MARK: - SuspectListView
struct SuspectListView: View {
    @ObservedObject var gameState: GameState
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Suspects")
                .font(.title)
                .bold()
                .foregroundColor(.white)
            
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(gameState.suspects.keys.sorted(), id: \.self) { suspect in
                        let emoji = gameState.suspects[suspect] ?? "❓"
                        HStack {
                            Text("\(emoji) \(suspect)")
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                            
                            Button("Ask for Clues"){
                                gameState.currentStage = .clueSharing(suspect)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.blue)
                            .disabled(gameState.gatheredClues.contains(suspect))
                            
                            Button {
                                gameState.currentStage = .interrogation(suspect)
                            } label: {
                                Text("Interrogate")
                                    + Text(gameState.gatheredClues.contains(suspect) ? "Checked✅" : "Unchecked🔒")
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.purple)
                            .disabled(!gameState.gatheredClues.contains(suspect) || gameState.interrogated.contains(suspect))
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.gray.opacity(0.3)))
                    }
                    
                    if !gameState.clues.isEmpty {
                        Divider().background(Color.white)
                        Text("Clues Collected:")
                            .font(.headline)
                            .foregroundColor(.white)
                        ScrollView {
                            VStack(alignment: .leading, spacing: 5) {
                                ForEach(gameState.clues, id: \.self) { clue in
                                    Text("• \(clue)")
                                        .foregroundColor(.white)
                                        .padding(5)
                                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.black.opacity(0.5)))
                                }
                            }
                        }
                        .frame(height: 150)
                        .padding(.horizontal)
                    }
                    
                    if gameState.allInterrogated() && !gameState.showSolveButton {
                        Button("Solve the Mystery?") {
                            gameState.showSolveButton = true
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.orange)
                    }
                    
                    Button("Gather Everyone") {
                            gameState.currentStage = .gather
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.orange)
                    }
                }
            }
        }
    }


// MARK: - ClueSharingView
struct ClueSharingView: View {
    @ObservedObject var gameState: GameState
    var suspect: String
    @State private var clueShown = false
    
    var body: some View {
        ZStack {
            gameState.backgroundColor(for: suspect)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text(gameState.suspects[suspect] ?? "❓")
                    .font(.system(size: 80))
                
                Text("\(gameState.suspects[suspect] ?? "❓") \(suspect) - Sharing Clues")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                
                if clueShown {
                    Text(gameState.foundClueFor(suspect: suspect))
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.black.opacity(0.6)))
                        .foregroundColor(.white)
                    
                    Button("Proceed to Interrogation") {
                        gameState.gatheredClues.insert(suspect)
                        gameState.currentStage = .interrogation(suspect)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    Button("Gather Everyone") {
                        gameState.currentStage = .gather
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    
                } else {
                    Button("Did you notice anything?") {
                        clueShown = true
                        gameState.clues.append(gameState.foundClueFor(suspect: suspect))
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                }
            }
            .padding()
        }
    }
}

// MARK: - InterrogationView
struct InterrogationView: View {
    @ObservedObject var gameState: GameState
    var suspect: String
    @State private var clueRevealed = false
    @State private var emojiScale: CGFloat = 1.0
    @State private var clueOpacity: Double = 0.0
    
    var body: some View {
        ZStack {
            gameState.backgroundColor(for: suspect)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text(gameState.suspects[suspect] ?? "❓")
                    .font(.system(size: 80))
                    .scaleEffect(emojiScale)
                    .animation(.easeInOut(duration: 0.5), value: emojiScale)
                    .onAppear {
                        emojiScale = 1.3
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            emojiScale = 1.0
                        }
                    }
                
                Text("Interrogating \(gameState.suspects[suspect] ?? "❓") \(suspect)")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                
                if clueRevealed {
                    Text(gameState.clueFor(suspect: suspect))
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.black.opacity(0.6)))
                        .foregroundColor(.white)
                        .opacity(clueOpacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.0)) {
                                clueOpacity = 1.0
                            }
                        }
                    
                    Button("Back to Suspects") {
                        gameState.interrogated.insert(suspect)
                        gameState.currentStage = .suspects
                        clueRevealed = false
                        clueOpacity = 0.0
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                } else {
                    Button("Where were you last night?") {
                        clueRevealed = true
                        gameState.clues.append(gameState.clueFor(suspect: suspect))
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                }
            }
            .padding()
        }
    }
}

// MARK: - GatherView
struct GatherView: View {
    @ObservedObject var gameState: GameState
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Everyone gathers at the main hall")
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.white)
            
            Text("You announce: 'The culprit who stole the Incoin is...'")
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.white)
            
            ForEach(gameState.suspects.keys.sorted(), id: \.self) { suspect in
                let emoji = gameState.suspects[suspect] ?? "❓"
                Button("\(emoji) \(suspect)") {
                    gameState.finalMessage = suspect
                    gameState.currentStage = .final
                }
                .buttonStyle(.borderedProminent)
                .tint(.orange)
            }
        }
        .padding()
    }
}

// MARK: - FinalRevealView
struct FinalRevealView: View {
    @ObservedObject var gameState: GameState
    
    var body: some View {
        VStack(spacing: 20) {
            if let chosen = gameState.finalMessage {
                let emoji = gameState.suspects[chosen] ?? "❓"
                if chosen == "Obama" {
                    Text("🎉 Well done! The police capture \(emoji) \(chosen). Incoin is saved!")
                        .multilineTextAlignment(.center)
                        .padding()
                        .foregroundColor(.green)
                        .bold()
                } else {
                    Text("❌ Oh no! That's wrong! \(emoji) \(chosen) has been wrongly accused and is now loathing you from their prison cell as the real culprit roams free!")
                        .multilineTextAlignment(.center)
                        .padding()
                        .foregroundColor(.red)
                        .bold()
                }
            }
            
            Button("Try Again") {
                gameState.currentStage = .start
                gameState.clues.removeAll()
                gameState.interrogated.removeAll()
                gameState.gatheredClues.removeAll()
                gameState.finalMessage = nil
                gameState.showSolveButton = false
                gameState.showGatherButton = false
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
