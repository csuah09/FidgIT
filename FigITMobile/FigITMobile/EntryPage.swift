//
//  EntryPage.swift
//  FigITMobile
//
//  Created by Charmaine Suah on 12/11/2024.
//

import Foundation
import SwiftUI

struct EntryPage: View {
    @Binding var showMainTabView: Bool

    var body: some View {
        VStack {
            Text("Welcome to FidgIT Mobile")
                .font(.largeTitle)
                .padding()
            
            Text("This app helps you track your well-being.")
                .font(.headline)
                .padding()
            
            Button(action: {
                showMainTabView = true // Navigate to the MainTabView
            }) {
                Text("Get Started")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
        }
    }
}


struct EntryPage_Previews: PreviewProvider {
    static var previews: some View {
        // Use .constant(false) for preview purposes
        EntryPage(showMainTabView: .constant(false))
    }
}
