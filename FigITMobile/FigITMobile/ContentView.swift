//
//  ContentView.swift
//  FigITMobile
//
//  Created by Charmaine Suah on 12/11/2024.
//

import SwiftUI


struct ContentView: View {
    @State private var showMainTabView = false // Toggle to show EntryPage or MainTabView
    
    var body: some View {
        if showMainTabView {
            MainTabView()
        } else {
            EntryPage(showMainTabView: $showMainTabView)
        }
    }
}
