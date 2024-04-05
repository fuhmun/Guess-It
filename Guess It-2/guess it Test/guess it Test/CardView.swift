//
//  CardView.swift
//  guess it Test
//
//  Created by Fahad Munawar on 10/1/23.
//

import Foundation
import SwiftUI
import AVFoundation

struct WordData: Codable {
    let word: String
    let forbiddenWords: [String]
}
struct CardView:View {
    @State var word: String = ""
    @State var forbiddenWords: String = ""
    @Binding var currentTeam: Team
    @Binding var teamOne: Int
    @Binding var teamTwo: Int
    @Binding var buzzerPlayer: AVAudioPlayer?
    @Binding var correctButtonSound: AVAudioPlayer?
    @Binding var passButtonSound: AVAudioPlayer?
    
    
    func correctAnswer() {
        if let correctAnswerSound = NSDataAsset(name: "correctAnswer") {
            do {
                correctButtonSound = try AVAudioPlayer(data: correctAnswerSound.data)
                correctButtonSound?.play()
            } catch {
                print("Error playing buzzer sound: \(error)")
            }
        }
    }
    
    func passingSound() {
        if let passingSound = NSDataAsset(name: "pass") {
            do {
                passButtonSound = try AVAudioPlayer(data: passingSound.data)
                passButtonSound?.play()
            } catch {
                print("Error playing buzzer sound: \(error)")
            }
        }
    }
    
    let images = ["blabberIt", "doodleIt", "mimeIt"]
    @State private var actionWords = 0
    func blabberShown(){
        actionWords = 0
    }
    func actionWord(){
        actionWords = Int.random(in: 0..<images.count)
    }
    func loadWord() {
        if let path = Bundle.main.path(forResource: "guessWords", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let words = try JSONDecoder().decode([WordData].self, from: data)
                
                if let wordData = words.randomElement() {
                    
                    self.word = wordData.word
                    self.forbiddenWords = wordData.forbiddenWords.joined(separator: ", ")
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }

   
   
    
    var body: some View{
        //GeometryReader { geometry in
        //ZStack{
            //RoundedRectangle(cornerRadius: 25)
                //.stroke(lineWidth: 13)
            VStack {
                
                Image(images[actionWords])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    //.padding()
                
                
                Text(word)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                
                
                VStack{
                    if actionWords == 0 {
                        
                        
                        Text("Forbidden Words:")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                            .padding()
                        
                        Text(forbiddenWords)
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .frame(width: 200)
                            .lineLimit(2)
                            .scaledToFit()
                            .minimumScaleFactor(0.15)
                    }else{
                        Text("")
                            .padding()
                        Text("")
                            .padding(.bottom, 48)
                    }
                }
            }
            HStack {
                //Pass button
                Button(action: {
                    //loadJSONData()
                    actionWord()
                    passingSound()
                    loadWord()
                }) {
                    Image(systemName: "arrow.left.square")
                        .font(.largeTitle)
                        .padding(.leading, 75.0)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                        
                    
                    
                }
                .padding()
                
                Spacer()
                
                // 1 point button
                Button(action: {
                    
                    switch currentTeam {
                    case .teamOne:
                        teamOne += 1
                    case .teamTwo:
                        teamTwo += 1
                    }
                    loadWord()
                    actionWord()
                    correctAnswer()
                }) {
                    Image(systemName: "checkmark.square")
                        .font(.largeTitle)
                        .padding(.trailing, 75.0)
                        .fontWeight(.bold)
                        .foregroundColor(Color.green)
                }
                .padding()
                
            }
        //}.
            .onAppear{
                loadWord()
            }
                
            }
        }
        
    //}
    



