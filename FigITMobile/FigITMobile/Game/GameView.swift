//
//  GameView.swift
//  FigITMobile
//
//  Created by Charmaine Suah on 13/11/2024.
//


import SwiftUI

struct GameView: View {
    @EnvironmentObject var progressModel: ProgressModel
    var body: some View {
        NavigationView {
            VStack {
                Text("Crashy Plane")
                    .font(.largeTitle)
                    .padding()

                Text("Tap below to play the game!")
                    .font(.headline)
                    .padding()

                NavigationLink(destination: GamePlayView()
                    .onAppear {
                // Increase points when the game starts
                progressModel.increaseProgress(by: 10) // Add 10 points for starting the game
                }) {
                    Text("Start Game")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                
            }
            .navigationTitle("Game")
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(ProgressModel()) 
    }
}
