//
//  MainTabView.swift
//  FigITMobile
//
//  Created by Charmaine Suah on 12/11/2024.
//


import SwiftUI

struct MainTabView: View {
    @StateObject var progressModel = ProgressModel()
    var body: some View {
        TabView {
            HomePage()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }.environmentObject(progressModel)
            DiaryView()
                .tabItem {
                    Label("Diary", systemImage: "book.fill")
                }.environmentObject(progressModel)
            
            PredictionPage()
                .tabItem {
                    Label("Predict", systemImage: "brain.head.profile")
                }.environmentObject(progressModel)
            
            GameView()
                .tabItem {
                    Label("Game", systemImage: "gamecontroller.fill")
                }.environmentObject(progressModel)
            
            GuideView()
                .tabItem {
                    Label("Guide", systemImage: "graduationcap.fill")
                }.environmentObject(progressModel)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
