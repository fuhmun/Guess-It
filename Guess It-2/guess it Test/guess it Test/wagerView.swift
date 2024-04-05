//
//  wagerView.swift
//  guess it Test
//
//  Created by Fahad Munawar on 10/6/23.
//

import SwiftUI

struct wagerView: View {
   
    @Binding var teamOneName: String
    @Binding var teamTwoName:String
    @Binding var wager: String
    @Binding var isWagerViewShown: Bool
    func closeWagerView(){
        isWagerViewShown = false
    }
        var body: some View {
            ZStack{
                Image("guessItScreenColors")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea(.all)
                
                VStack{
                   Spacer()
                    Text ("Options")
                        
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.linearGradient(colors: [.blue, .blue, .orange, .purple, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                    
                        
                        
                        Spacer()
                        
                    VStack{
                        TextField ("Team 1", text: $teamOneName)
                        
                            .frame( width: 200,  height: 80 )
                            .font (.largeTitle)
                            .bold()
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color .red))
                        
                        TextField ("Team 2" , text: $teamTwoName)
                            .frame( width: 200,  height: 80 )
                            .font (.largeTitle)
                            .bold()
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color .blue))
                        TextField ("Wager" , text: $wager)
                            .frame( width: 200,  height: 80 )
                            .font (.largeTitle)
                            .bold()
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color .orange))
                    }
                    .autocorrectionDisabled()
                   Spacer()
                    Button({"OK"}(), action: {closeWagerView()})
                        .foregroundColor(.white)
                        
                        .frame( width: 100,  height: 40 )
                        .font (.title)
                        .bold()
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(.linearGradient(colors: [.blue, .blue, .orange, .purple, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)))
                                        Spacer()
                }
                .multilineTextAlignment(.center)
                //.frame(width: 30.0, height: 30.0)
            
               
                
            }
        }
        }




