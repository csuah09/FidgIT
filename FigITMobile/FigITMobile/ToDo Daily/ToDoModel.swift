//
//  ToDoModel.swift
//  FigITMobile
//
//  Created by Charmaine Suah on 13/11/2024.
//

import Foundation

// Define the ToDoTask model
struct ToDoTask: Identifiable {
    let id = UUID()
    let title: String
    var isCompleted: Bool
    var isCounted: Bool
}

// Provide sample data
extension ToDoTask {
    static let sample = [
        ToDoTask(title: "Play Crashy Plane", isCompleted: false, isCounted: false),
        ToDoTask(title: "Daily Diary Entry", isCompleted: true, isCounted: false),
        ToDoTask(title: "Read New Guide", isCompleted: false, isCounted: false),
    ]
}
