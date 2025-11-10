//
//  GuideView.swift
//  FigITMobile
//
//  Created by Charmaine Suah on 13/11/2024.
//
import SwiftUI

struct GuideView: View {
    @ObservedObject var moodModelController = MoodModelController()
    @State private var show = false
    @State private var txt = ""
    @State private var docID = ""
    @State private var remove = false

    var body: some View {
        VStack {
            Text("CBT Guide")
                .font(.title)
                .padding()
            
            ArticleListView() // shows summaries of articles

            // Add a horizontal layout for the prompt and button on the right side
            HStack {
                Text("Add your insights:")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
//                Spacer() // Pushes the button to the far right 
                
                Button(action: {
                    self.txt = ""
                    self.docID = ""
                    self.show.toggle()
                }) {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.yellow)
                .clipShape(Circle())
            }
            .padding([.leading,.trailing, .top]) // Adds padding around the button and prompt
        }
        .sheet(isPresented: $show) {
            AddInsightsView(moodModelController: self.moodModelController)
        }
    }
}

struct GuideView_Previews: PreviewProvider {
    static var previews: some View {
        GuideView()
    }
}
