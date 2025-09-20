//
//  ContentView.swift
//  SSTINC_projectwork
//
//  Created by Kirsten Petros on 1/9/25.
//

import SwiftUI

class GameState: ObservableObject {
    @Published var currentStage: Stage = .start
    @Published var clues: [String] = []
    @Published var interrogated: Set<String> = []
    @Published var showSolveButton: Bool = false
    @Published var showGatherButton: Bool = false
    @Published var finalMessage: String? = nil
    
    enum Stage {
        case start
        case suspects
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
            return "(Obama) I have no clue what your talking about… 🎵 *humming the American National Anthem*"
        case "Joshua":
            return "(Joshua) I noticed someone running past the hallway late last night. They were humming a familiar patriotic tune."
        case "Kesler":
            return "(Kesler) Heard heavy footsteps and a little tune… sounded oddly like the national anthem."
        case "Elon Musk":
            return "(Elon Musk) Saw someone leave quickly while humming something… could’ve been a song from the radio? It reminded me of a national tune."
        case "Bill Gates":
            return "(Bill Gates) I saw shadows moving fast. There was humming… almost sounded like the American anthem."
        case "Taylor Swift":
            return "(Taylor Swift) I heard footsteps running away and humming a patriotic song… I think it was the national anthem."
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
    var body: some View {
        NavigationStack {   // Put everything inside NavigationStack
            
            ZStack {
                
                Color.black
                
                    .ignoresSafeArea() // full black background
                
                
                
                VStack {
                    
                    Text("INCOIN HEIST")
                    
                        
                    
                        .fontWeight(.bold)
                    
                        .foregroundStyle(.green)
                    
                        .padding(.top, 40)
                        .font(.custom("american typewriter", size: 50))
                    
                    
                    
                    Text("ARE YOU READY TO BEGIN THE INVESTIGATION?")
                    
                        .foregroundStyle(.red)
                    
                    
                        .fontWeight(.bold)
                    
                        .padding(.top, 20)
                    
                        .font(.custom("menlo", size: 30))
                    
                    
                    Spacer()
                    
                    
                    
                    NavigationLink {
                        
                        Intro_page()
                        
                    } label: {
                        
                        Text("Click for instructions")
                        
                            .font(.title)
                        
                            .fontWeight(.bold)
                        
                            .foregroundColor(.white)
                        
                            .padding()
                        
                            .frame(width: 200, height: 60)
                        
                            .background(Color.orange)
                        
                            .cornerRadius(12)
                        
                    }
                    .padding()
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
