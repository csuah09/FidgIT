//
//  InsightDiaryView.swift
//  FigITMobile
//
//  Created by Charmaine Suah on 13/11/2024.
//

import SwiftUI

struct AddInsightsView: View {
    @ObservedObject var moodModelController: MoodModelController
    @Environment(\.presentationMode) var presentationMode
    
    @State var text: String? = nil
    @State private var emotionState: EmotionState = .happy
    @State private var moodColor: MoodColor = .happyColor
    @State private var happyIsSelected = false
    @State private var mehIsSelected = false
    @State private var sadIsSelected = false
    @State private var counterLabel = "200/200"
    
    var body: some View {
        VStack(spacing: 30) {
            Text("New Insights Entry").font(.largeTitle)
            HStack {
                Button(action: {
                    self.emotionState = .happy
                    self.moodColor = .insightColour
                    self.happyIsSelected = true
                    self.mehIsSelected = false
                    self.sadIsSelected = false
                }) {
                    Image("happy").resizable().frame(width: 50, height: 50).foregroundColor(.green).background(happyIsSelected ? Color.yellow : Color.clear).clipShape(Circle())
                }
                
                Button(action: {
                    self.emotionState = .meh
                    self.moodColor = .insightColour
                    self.mehIsSelected = true
                    self.happyIsSelected = false
                    self.sadIsSelected = false
                }) {
                    Image("meh").resizable().frame(width: 50, height: 50).foregroundColor(.gray).background(mehIsSelected ? Color.yellow : Color.clear).clipShape(Circle())
                }
                
                Button(action: {
                    self.emotionState = .sad
                    self.moodColor = .insightColour
                    self.sadIsSelected = true
                    self.happyIsSelected = false
                    self.mehIsSelected = false
                }) {
                    Image("sad").resizable().frame(width: 50, height: 50).foregroundColor(.red).background(sadIsSelected ? Color.yellow : Color.clear).clipShape(Circle())
                }
            }
            ZStack(alignment: .bottomTrailing) {
            MultiLineTextField(txt: $text, counterLabel: $counterLabel).frame(height: 100).cornerRadius(20)
                Text("Remaining: \(counterLabel)").font(.footnote).foregroundColor(.gray).padding([.bottom, .trailing], 8)
        }
            Button(action: {
                    self.moodModelController.createMood(emotion: Emotion(state: self.emotionState, color: self.moodColor), comment: self.text, date: Date())
                    
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Add Insights To Diary").bold().frame(width: UIScreen.main.bounds.width - 30, height: 50).background(Color.blue).foregroundColor(.white).cornerRadius(10)
            }
            Spacer()
        }.padding()
    }

}

struct AddInsightsView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        AddInsightsView(moodModelController: MoodModelController(), text: "text")
    }
}
