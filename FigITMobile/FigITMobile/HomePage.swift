//
//  HomePage.swift
//  FigITMobile
//
//  Created by Charmaine Suah on 12/11/2024.
//


import SwiftUI
struct HomePage: View {
    @EnvironmentObject var progressModel: ProgressModel
    var body: some View {
        VStack {
            Text("Personal Progress")
                .font(.title)
            
            ProgressView(value: progressModel.progress, total: 100){
                Text("Level Progress")
            }currentValueLabel: {
                Text("\(Int(progressModel.progress))%")
            }
                .progressViewStyle(LinearProgressViewStyle())
                .padding()
            
            Image(systemName: "heart")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)
                .padding()

            Text("Level : \(Int(progressModel.currentLevel))")
                .font(.headline)
            
            Text("Daily To-Do List")
                .font(.title2)
                .padding(.top)
            
            // Placeholder for to-do list items
            ToDoListView()
        }
        .padding()
    }
}

struct HomePage_Previews: PreviewProvider {
  static var previews: some View {
      HomePage().environmentObject(ProgressModel())
  }
}

