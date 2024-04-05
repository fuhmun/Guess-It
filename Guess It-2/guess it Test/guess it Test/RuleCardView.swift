//
//  RuleCardView.swift
//  guess it Test
//
//  Created by Fahad Munawar on 10/1/23.
//

import SwiftUI
import Foundation

struct RulesView: View {
    let views: [AnyView] = [
        AnyView(HouseRules()),
        AnyView(BlabberRules()),
        AnyView(DoodleRules()),
        AnyView(MimeRules(isRuleShown: .constant(true)))
    ]
    
    @State private var selectedTabIndex = 0
    
    var body: some View {
        VStack {
            Spacer()
            Text("RULES")
                .font(.largeTitle)
                .fontWeight(.bold)
                .shadow(radius: 10)
                .padding(.vertical, 75)
            
            TabView(selection: $selectedTabIndex) {
                ForEach(0..<views.count, id: \.self) { index in
                    views[index]
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
           
            Spacer()
        }
    }
}

struct RulesView_Previews: PreviewProvider {
    static var previews: some View {
        RulesView()
    }
}
