//
//  ToDoListView.swift
//  FigITMobile
//
//  Created by Charmaine Suah on 13/11/2024.

import SwiftUI

struct ToDoListView: View {
    @State private var items = ToDoTask.sample.shuffled()
    @State private var timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect() // Triggers every minute
    
    @EnvironmentObject var progressModel: ProgressModel
    var body: some View {
        List {
            ForEach($items) { $item in
                HStack {
                    Image(systemName: item.isCompleted ? "largecircle.fill.circle" : "circle")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                        .onTapGesture {
                            if !item.isCompleted {
                                item.isCompleted = true
                            if !item.isCounted {
                                progressModel.increaseProgress(by: 2)
                                item.isCounted = true
                            }
                                }else {
                                    item.isCompleted = false
                                    item.isCounted = false // Reset if unchecked
                                }
                            
                }
                    Text(item.title)
                        .strikethrough(item.isCompleted)
                        .foregroundColor(item.isCompleted ? .gray : .primary)
                }
            }
        }
        .navigationTitle("To Do List")
        .onReceive(timer) { _ in
                    checkForMidnight()
                }
    }


    // 12 am == 00:00
func checkForMidnight() {
      let currentHour = Calendar.current.component(.hour, from: Date())
      let currentMinute = Calendar.current.component(.minute, from: Date())
      
      if currentHour == 0 && currentMinute == 0 {
          resetTasks()
      }
  }
  
  // loop over all tasks and mark as not complete
  func resetTasks() {
      for index in items.indices {
          items[index].isCompleted = false
      }
  }
}


struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView().environmentObject(ProgressModel())
    }
}
