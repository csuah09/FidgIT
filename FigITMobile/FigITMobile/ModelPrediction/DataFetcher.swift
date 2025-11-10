import Foundation
import CoreML
import SwiftUI

class DataFetcher: ObservableObject {
    @Published var predictionResult: String = "Not classified yet"
    @Published var showAlert: Bool = false // Published property to trigger the alert

    let testData: [[Double]] = [
        [0, 1917, 6798, 0],
        [0, -14144, 28554, 0],
        [0, -31068, -25066, 0],
        [0, 21434, -26816, 0],
        [0, 14108, -4744, 0],
        [0, -22293, -24675, 0],
        [0, -15147, -3947, 0],
        [0, 8522, 22317, 0],
        [0, -14016, -18622, 0],
        [0, 8273, 3584, 0]
    ]

    func testPrediction() {
        do {
            let model = try fidget_cnn_lstm_binary_model(configuration: MLModelConfiguration())
            let inputArray = try MLMultiArray(shape: [1, 10, 4], dataType: .float32)

            for (i, dataPoint) in testData.enumerated() {
                inputArray[i * 4 + 0] = NSNumber(value: Float(dataPoint[0]))
                inputArray[i * 4 + 1] = NSNumber(value: Float(dataPoint[1]))
                inputArray[i * 4 + 2] = NSNumber(value: Float(dataPoint[2]))
                inputArray[i * 4 + 3] = NSNumber(value: Float(dataPoint[3]))
            }

            let input = fidget_cnn_lstm_binary_modelInput(conv1d_input: inputArray)
            if let prediction = try? model.prediction(input: input) {
                if prediction.Identity[0].intValue == 1 {
                    predictionResult = "Stressed"
                    showAlert = true // Trigger the alert
                } else {
                    predictionResult = "Not Stressed"
                }
            } else {
                predictionResult = "Prediction failed"
            }
        } catch {
            predictionResult = "Model error: \(error)"
            print("Error analyzing data: \(error)")
        }
    }
}
