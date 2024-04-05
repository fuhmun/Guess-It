//
//  RuleView3.swift
//  guess it Test
//
//  Created by Fahad Munawar on 10/1/23.
//

import Foundation
import SwiftUI

struct DoodleRules: View {
    var body: some View {
        VStack {
            Spacer()
            Image("doodleIt")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 100)
            
            
            Text("DRAW THE CLUES")
            Spacer()
        }
    }
}

struct DoodleRules_Previews: PreviewProvider {
   static var previews: some View {
       DoodleRules()
   }
}
