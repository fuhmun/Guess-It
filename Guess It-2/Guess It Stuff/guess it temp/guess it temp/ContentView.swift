//
//  ContentView.swift
//  guess it temp
//
//  Created by Leon Singleton on 9/23/23.
//

import SwiftUI
import Foundation

enum Team {
    case teamA
    case teamB
}

struct ContentView: View {
    @State private var isCardShown = false
    @State private var teamA = 0
    @State private var teamB = 0
    @State private var currentTeam = Team.teamA // Start with Team A
    @State private var word = "Sample Word"
    @State private var timeRemaining = 60
    @State private var timer: Timer? = nil

    var body: some View {
        VStack {
            Text("Team: \(currentTeam == .teamA ? "A" : "B")")
                .font(.largeTitle)
            
            Text("Team A Score: \(teamA)")
            Text("Team B Score: \(teamB)")

            Button(action: {
                startTimer()
                isCardShown.toggle()
                // Generate a new word when the card is shown
                if isCardShown {
                    word = generateNewWord()
                }
            }) {
                Text("Show Card")
            }

            // Sheet to show the card
            Button(action: {
                isCardShown.toggle()
            }) {
                Text("Show Card Sheet")
            }
            .sheet(isPresented: $isCardShown) {
                CardView(word: $word, currentTeam: $currentTeam, teamA: $teamA, teamB: $teamB)
            }
        }
    }

    // Function to generate a new word (customize this)
    func generateNewWord() -> String {
        // Replace this with your word generation logic
        let words = ["Word 1", "Word 2", "Word 3", "Word 4"]
        return words.randomElement() ?? "Default Word"
    }

    // Start the timer
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer.invalidate()
                switchTurns()
            }
        }
    }

    // Switch turns between teams
    func switchTurns() {
        currentTeam = (currentTeam == .teamA) ? .teamB : .teamA
        timeRemaining = 60 // Reset the timer
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    @Binding var word: String
    @Binding var currentTeam: Team
    @Binding var teamA: Int
    @Binding var teamB: Int

    var body: some View {
        VStack {
            Text(word)
                .font(.largeTitle)
                .padding()

            HStack {
                Button(action: {
                    // Handle left arrow button press (e.g., move to the next word)
                    word = generateNewWord()
                }) {
                    Image(systemName: "arrow.left")
                }
                .padding()

                Spacer()

                Button(action: {
                    // Handle checkmark button press (e.g., increment score)
                    switch currentTeam {
                    case .teamA:
                        teamA += 1
                    case .teamB:
                        teamB += 1
                    }
                    word = generateNewWord()
                }) {
                    Image(systemName: "checkmark")
                }
                .padding()
            }
        }
    }

    // Function to generate a new word (customize this)
    func generateNewWord() -> String {
        // Replace this with your word generation logic
        let words = ["Word 1", "Word 2", "Word 3", "Word 4"]
        return words.randomElement() ?? "Default Word"
    }
}

@main
struct GuessingGameApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
