//
//  RuleView2.swift
//  guess it Test
//
//  Created by Fahad Munawar on 10/1/23.
//

import Foundation
import SwiftUI

struct BlabberRules: View {
    var body: some View {
        VStack {
            Spacer()
            Image("blabberIt")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 100)
            Text("GIVE VERBAL CLUES\nCANNOT SAY\n THE WORD,FORBIDDEN WORDS\nOR PART OF THOSE WORDS")
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
}

struct BlabberRules_Previews: PreviewProvider {
   static var previews: some View {
       BlabberRules()
   }
}
