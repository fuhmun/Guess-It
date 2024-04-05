//
//  MimeRules.swift
//  guess it Test
//
//  Created by Fahad Munawar on 10/1/23.
//

import Foundation
import SwiftUI

struct MimeRules: View {
    @Binding var isRuleShown: Bool
    var body: some View {
        VStack {
            Spacer()
            Image("mimeIt")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 100)
            Text("ACT OUT THE CLUES")
                .padding(.bottom, 25)
//            Button(action: {isRuleShown.toggle()}, label: {Text("GOT IT")})
            Spacer()
           
            
        }
        
    }
}

struct MimeRules_Previews: PreviewProvider {
   static var previews: some View {
       MimeRules(isRuleShown: .constant(true))
   }
}
