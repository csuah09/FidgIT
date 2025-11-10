//
//  PredictionPage.swift
//  FigITMobile
//
//  Created by Charmaine Suah on 12/11/2024.
//

import SwiftUI

struct PredictionPage: View {
    @ObservedObject var dataFetcher = DataFetcher()

    var body: some View {
        VStack {
            Text("FidgIT Prediction")
                .font(.title)
                .padding()
                
            Text("Prediction Result: \(dataFetcher.predictionResult)")
                .font(.headline)
                .foregroundColor(.blue)
                .padding()

            Button("Run Prediction") {
                dataFetcher.testPrediction()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .alert(isPresented: $dataFetcher.showAlert) {
            Alert(
                title: Text("Stress Alert"),
                message: Text("High stress levels detected. Please take a moment to relax. You can try: \n Reading a guide \n Play a game \n Write in your diary"),
                dismissButton: .default(Text("Got it!"))
            )
        }
        .onAppear {
            print("PredictionPage appeared.")
        }.navigationTitle( "FidgIT Prediction")
    }
}

struct PredictionPage_Previews: PreviewProvider {
    static var previews: some View {
        PredictionPage()
    }
}
