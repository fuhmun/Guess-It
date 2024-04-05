//
//  RuleView1.swift
//  guess it Test
//
//  Created by Fahad Munawar on 10/1/23.
//

import Foundation
import SwiftUI
struct HouseRules: View{
    var body: some View{
        VStack{
            VStack(spacing: 5) {
                Spacer()
                        Text("MAKE TWO TEAMS")
                        Text("PICK A CLUE GIVER PER TEAM EACH ROUND")
                        HStack {
                            Text("GUESS THE RIGHT WORD, PRESS ")
                            
                            Image(systemName: "checkmark.square")
                                .foregroundColor(.green)
                                .fontWeight(.bold)
                        }
                        HStack {
                            Text("NEED A PASS, PRESS ")
                            Image(systemName: "arrow.left.square")
                                .foregroundColor(.red)
                                .fontWeight(.bold)
                        }
                        Text("GET A POINT FOR EVERY CORRECT GUESS")
                        Text("FIRST TO 35 WIN")
                Spacer()
                    }
            
            
        }
    }
}


struct HouseRules_Previews: PreviewProvider {
   static var previews: some View {
       HouseRules()
   }
}
