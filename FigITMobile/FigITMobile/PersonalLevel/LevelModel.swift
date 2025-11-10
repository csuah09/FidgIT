//
//  LevelModel.swift
//  FigITMobile
//
//  Created by Charmaine Suah on 13/11/2024.
//

import SwiftUI
import Combine

class ProgressModel: ObservableObject {
    @Published var progress: Float = 20
    @Published var currentLevel: Int = 1
    
    func increaseProgress(by amount: Float) {
        progress += amount
        if progress > 100 { // Cap progress at 100%
            increaseLevel()
            progress = 0
        }
    }
    
    func increaseLevel() {
        currentLevel += 1
    }
    
   

}
