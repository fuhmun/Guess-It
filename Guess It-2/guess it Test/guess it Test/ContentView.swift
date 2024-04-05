//
//  ContentView.swift
//  guess it Test
//
//  Created by Fahad Munawar on 9/20/23.
//

import SwiftUI
import Foundation
import AVFoundation

enum Team {
    case teamOne, teamTwo
    
}

struct ContentView: View {
    
    //bools
    @State var isCardShown = false
    @State var isRuleShown = false
    @State var isMusicPlaying = true
    @State var isWinnerCardShown = false
    @State var isBlabberItShown = false
    @State var showTimesUp = false
    @State var isSetupShown = false
    @State var PlusSignPressed = false
    
    @State var teamOne = 0
    @State var teamTwo = 0
    @State var timeLeft: Int = 60
    
    // to call the Clue words and forbidden
    @State var word = [String] ()
    @State var forbiddenWords = [String] ()
    @State var words = [String] ()
   
    @State var currentTeam = Team.teamOne // show who turn it is
    
    @State var teamOneName: String = "Team 1"
    @State var teamTwoName: String = "Team 2"
    @State var wager: String = ""
    
    // to start timer
    @State var timer: Timer? = nil
    @State var winnerS: AVAudioPlayer?
    //for buzzer sound
    @State var buzzerPlayer: AVAudioPlayer?
    @State var passButtonSound: AVAudioPlayer?
    @State var correctButtonSound: AVAudioPlayer?
    @State var tickTimerSound: AVAudioPlayer?
   @State var isWagerViewShown = false
    
    var isGameOver: Bool {
        return teamOne >= 35 || teamTwo >= 35
    }
    func winnerSound() {
        if let winSound = NSDataAsset(name: "winningSound") {
            do {
                winnerS = try AVAudioPlayer(data: winSound.data)
                winnerS?.play()
                
            } catch {
                print("Error playing winning sound: \(error)")
            }
        }
    }
    var winningTeam: Team? {
            if teamOne >= 35 {
                return .teamOne
            } else if teamTwo >= 35 {
                return .teamTwo
            } else {
                return nil
            }
        }
    // Start the timer
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeLeft > 0 {
                timeLeft -= 1
            } else {
                timer.invalidate()
                timesUp()
            }
        }
    }
     // time up sign
    struct TimeUpSign: View {
        var body: some  View {
            ZStack {
               
                    Color.red
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Spacer()
                        Text("TIMES UP!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                        
                        
                        
                        Spacer()
                    }
                }
            }
        }
        
    // Switch turns between teams
    func switchTurns() {
        currentTeam = (currentTeam == .teamOne) ? .teamTwo : .teamOne
    }
    //  play buzzer
    func playBuzzerSound() {
        if let buzzerSound = NSDataAsset(name: "Buzzer") {
            do {
                buzzerPlayer = try AVAudioPlayer(data: buzzerSound.data)
                buzzerPlayer?.play()
            } catch {
                print("Error playing buzzer sound: \(error)")
            }
        }
    }
    
   
    
    func playTickTimer() {
        if let tickingTimerSound = NSDataAsset(name: "clockTicking") {
            do {
                tickTimerSound = try AVAudioPlayer(data: tickingTimerSound.data)
                tickTimerSound?.numberOfLoops = -1
                tickTimerSound?.play()
            } catch {
                print("Error playing buzzer sound: \(error)")
            }
        }
    }
    func timerSpeed(){
        if timeLeft <= 30 {
            tickTimerSound?.rate = 1.5
        }else if timeLeft <= 10{
            tickTimerSound?.rate = 2.0}
        else if timeLeft >= 60 { tickTimerSound?.rate = 1.0
    }
        }
    
    
        // for once the time is up
        func timesUp() {
            isCardShown = false //drop card
            if isGameOver{
                isWinnerCardShown.toggle()
                tickTimerSound?.stop()
                winnerSound()
                teamOne = 0
                teamTwo = 0
                currentTeam = Team.teamOne
                timeLeft = 60
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.00) {
                    isWinnerCardShown.toggle()
                    
                }
            
            }else {
                showTimesUp = true // Show "Time's Up" sign
                
                
                playBuzzerSound() // Play the buzzer
                tickTimerSound?.stop()
                timeLeft = 60 // Reset the timer
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.00) {
                    // how long time up screen shows
                    showTimesUp = false // Hide "Time's Up" sign
                    switchTurns() }// Switch the teams
            }
        }
        
       //  generate a words
        func generateNewWord() -> String {
            let words = ["Word 1", "Word 2", "Word 3", "Word 4"]
            return words.randomElement() ?? "Default Word"
        }
    func musicSwitch() {
        isMusicPlaying.toggle()
        if isMusicPlaying == true {
        } else {}
    }
    
   
    
   
    var body: some View {
        
        //GeometryReader { geometry in
        ZStack{
            
            Image("guessItScreenColors")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea(.all)
            VStack{
                
                HStack{
                    VStack{
                        
                        //placement for team one name and score
                        Text ("\(teamOneName)")
                            .frame(width: 100, height: 50)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.linearGradient(colors: [.red, .orange, .yellow], startPoint: .bottomLeading, endPoint: .topTrailing))
                            .multilineTextAlignment(.center)
                            .padding(.leading, 25.0)
                        Text ("\(teamOne)").font(.headline).fontWeight(.bold).padding(.leading, 30)
                        
                    }
                    //placement for logo
                    Image( "guessItLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit
                        )
                    VStack{
                        //placement for team two name and score
                        Text("\(teamTwoName)")
                            .frame(width: 100, height: 50)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.linearGradient(colors: [.purple, .indigo, .cyan, .cyan, .blue, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .multilineTextAlignment(.center)
                            .padding(.trailing, 25.0)
                        Text("\(teamTwo)")
                            .font(.headline)
                            .fontWeight(.black)
                            .padding(.trailing, 25)
                    }
                    
                    
                }
                .padding(.top, 45.0)
                
                    if isCardShown == true {
                        Text("Team \(currentTeam == .teamOne  ?  "1" : "2")")
                            .font(.largeTitle)
                        HStack{
                            Text(":")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Text("\(timeLeft)")
                                .font(.largeTitle)
                            
                        }
                        
                    }else {
                        
                    }
                
                Spacer()
                //playbutton
                Button(action: {
                    startTimer()
                    //tickTimerSound?.play()
                    //timerSpeed()
                    playTickTimer()
                    
                    isCardShown.toggle()
                   
                    //generateNewWord()
                    //DispatchQueue.main.async {
                            //timerSpeed()
                        //}
                })
                {
                    Image(systemName: "play.rectangle.fill")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    //.foregroundColor(.yellow) //yellow box
                    //playing around with box color
                        //.padding(.vertical, 25.0)
                        .foregroundStyle(.linearGradient(colors: [.blue, .blue, .orange, .purple, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                    
                    
                }// end of button
                
                Spacer()
                //Spacer()
                
                
                HStack{
                    
                    Button(action: { isWagerViewShown.toggle()
                        
                    }) {
                        Image(systemName:("plus"))
                    }
                    .foregroundColor(Color("DarkLightMode"))
                    .padding(.leading, 25.0)
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    
                    Spacer()
                    Button(action:{isRuleShown.toggle()})
                    { Image(systemName: ("questionmark.circle")
                    )}
                }
                .foregroundColor(Color("DarkLightMode"))
                .fontWeight(.bold)
                .font(.largeTitle)
                .padding(.trailing, 25.0)
                .padding(.bottom, 100)
            }//end of vstack
            
            Spacer()
            
            .sheet(isPresented: $isCardShown) {
                CardView(currentTeam: $currentTeam, teamOne: $teamOne, teamTwo: $teamTwo, buzzerPlayer: $buzzerPlayer, correctButtonSound: $correctButtonSound, passButtonSound: $passButtonSound )
                .presentationDetents([.fraction(0.65)])
                
                } // end of sheet
            
            .sheet(isPresented: $isRuleShown){
                RulesView()
            }
            .sheet(isPresented: $isWinnerCardShown) {WinnerView()}
            
            .sheet(isPresented: $isWagerViewShown) {
                wagerView(teamOneName:$teamOneName, teamTwoName:$teamTwoName, wager: $wager, isWagerViewShown: $isWagerViewShown )}
            //time up creen pops
            if showTimesUp {
                TimeUpSign()
            }
           
            
            
           
            
            } //end of z stack
        
        } //end of contentview
    
            
    }
        
    
//}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//init() {
    //if let passButtonSoundURL = Bundle.main.url(forResource: "pass", withExtension: "wav"),
      // let correctButtonSoundURL = Bundle.main.url(forResource: "correctAnswer", withExtension: "wav"),
       //let tickTimerSoundURL = Bundle.main.url(forResource: "clockTicking", withExtension: "wav"),
      //  let buzzerPlayerURL = Bundle.main.url(forResource: "Buzzer", withExtension: "wav")
    //{
    //    do {
       //     correctButtonSound = try AVAudioPlayer(contentsOf: correctButtonSoundURL)
       //     passButtonSound = try AVAudioPlayer(contentsOf: passButtonSoundURL)
        //    tickTimerSound = try AVAudioPlayer(contentsOf: tickTimerSoundURL)
       //     buzzerPlayer = try AVAudioPlayer(contentsOf: buzzerPlayerURL)
       //     buzzerPlayer = try AVAudioPlayer(contentsOf: buzzerPlayerURL)
     //   }catch {
     //       print("Error loading sound files: \(error)")
    //    }
  //  }
//}
