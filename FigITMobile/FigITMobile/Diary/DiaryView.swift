//
//  DiaryView.swift
//  FigITMobile
//
//  Created by Charmaine Suah on 12/11/2024.
//


import SwiftUI

struct DiaryView: View {
    
    @ObservedObject var moodModelController = MoodModelController()
    @State var show = false
    @State var txt = ""
    @State var docID = ""
    @State var remove = false
    
    
    //    init() {
    //
    //        UINavigationBar.appearance().backgroundColor = .systemRed
    //
    //         UINavigationBar.appearance().largeTitleTextAttributes = [
    //            .foregroundColor: UIColor.white]
    //
    //    }
    //
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                
                VStack(spacing: 0) {
                    List {
                        ForEach(self.moodModelController.moods, id: \.id) { mood in
                            MoodRowView(mood: mood)
                        }
                        .onDelete { index in
                            self.moodModelController.deleteMood(at: index)
                        }
                    }
                    Spacer()
                }
                Spacer()
                Button(action: {
                    self.txt = ""
                    self.docID = ""
                    self.show.toggle()
                }) {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.red)
                .clipShape(Circle())
                .padding()
            }
            .sheet(isPresented: self.$show) {
                AddMoodView(moodModelController: self.moodModelController)
            }
//            .animation(.default)
            .navigationBarTitle("Mood Diary")
            .navigationBarItems(
                trailing: NavigationLink(destination: CalendarView(start: Date(), monthsToShow: 1, daysSelectable: true, moodController: moodModelController)) {
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            )
            .onAppear {
                self.moodModelController.loadFromPersistentStore()
                print("Data reloaded from persistent store on view appear.")
            }
            .accentColor(.gray)
        }
    }
}


class Host : UIHostingController<ContentView>{
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return .lightContent
    }
}

struct DiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryView()
    }
}
