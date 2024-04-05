//
//  winnerCardView.swift
//  guess it Test
//
//  Created by Fahad Munawar on 10/1/23.
//

import Foundation
import SwiftUI
import AVFoundation
struct WinnerView: View {
    @State private var animationAmount = 1.0
    @State var winnerS: AVAudioPlayer?
//    @Binding var winningTeam: Team?
//    @Binding var teamOneName: String
//    @Binding var teamTwoName: String
    //static let customColor = Color(hex: 0xFF7676)
  
    
    var body: some View{
        ZStack{
           Image("guessItScreenColors")
                .resizable()
                .ignoresSafeArea()
                      Circle()
                           .fill(Color.blue)
                           .frame(width: 12, height: 12)
                           .modifier(ParticlesModifier())
                           .offset(x: -100, y : -50)
                       
                       Circle()
                           .fill(Color.yellow)
                           .frame(width: 12, height: 12)
                           .modifier(ParticlesModifier())
                           .offset(x: 60, y : 70)
                       Circle()
                           .fill(Color.orange)
                           .frame(width: 12, height: 12)
                           .modifier(ParticlesModifier())
                           .offset(x: -100, y : -50)
            Circle()
                 .fill(Color.blue)
                 .frame(width: 12, height: 12)
                 .modifier(ParticlesModifier())
                 .offset(x: -80, y : -100)
                       
                       Circle()
                           .fill(Color.purple)
                           .frame(width: 12, height: 12)
                           .modifier(ParticlesModifier())
                           .offset(x: 60, y : 70)
            VStack{
                Image("guessItLogo")
                    .resizable()
                    .frame(width: 250 ,height: 250)
                    .scaledToFit()
                Spacer()
                VStack{
                    Text("WINNER")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.linearGradient(colors: [.blue, .blue, .blue, .orange, .orange,.purple, .purple, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
//
//
//                    if winningTeam =.teamOne >= 35 {
//                        Text("\(teamOneName)")
//                    }else if winningTeam.teamTwo >= 35{
//                        Text("\(teamTwoName)")
//
//                }
//                    else{
//
                   }
                .scaleEffect(animationAmount)
                                .animation(.easeInOut(duration: 1)
                                    .repeatCount(3, autoreverses: true),
                                           value: animationAmount)
                                .onAppear{
                                    animationAmount += 1
            }
                                .padding(.bottom, 200)
                Spacer()
            }
            
        }
    }
}
struct FireworkParticlesGeometryEffect : GeometryEffect {
    var time : Double
    var speed = Double.random(in: 20 ... 200)
    var direction = Double.random(in: -Double.pi ...  Double.pi)
    
    var animatableData: Double {
        get { time }
        set { time = newValue }
    }
    func effectValue(size: CGSize) -> ProjectionTransform {
        let xTranslation = speed * cos(direction) * time
        let yTranslation = speed * sin(direction) * time
        let affineTranslation =  CGAffineTransform(translationX: xTranslation, y: yTranslation)
        return ProjectionTransform(affineTranslation)
    }
}
struct ParticlesModifier: ViewModifier {
    @State var time = 0.0
    @State var scale = 0.1
    let duration = 5.0
    
    func body(content: Content) -> some View {
        ZStack {
            ForEach(0..<80, id: \.self) { index in
                content
                    .hueRotation(Angle(degrees: time * 80))
                    .scaleEffect(scale)
                    .modifier(FireworkParticlesGeometryEffect(time: time))
                    .opacity(((duration-time) / duration))
            }
        }
        .onAppear {
            withAnimation (.easeOut(duration: duration)) {
                self.time = duration
                self.scale = 1.0
                
            }
            
        }
    }
}
struct WinnerView_Previews: PreviewProvider {
    static var previews: some View {
        WinnerView()
    }
}
