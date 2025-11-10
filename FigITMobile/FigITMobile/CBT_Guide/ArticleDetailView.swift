//
//  ArticleDetailView.swift
//  FigITMobile
//
//  Created by Charmaine Suah on 13/11/2024.
//


import SwiftUI

struct ArticleDetailView: View {
    @EnvironmentObject var progressModel: ProgressModel
    @State private var isArticleRead: Bool = false
    @State private var isAtEnd: Bool = false // Tracks if user reached end
    let article: Article
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(article.title).font(.largeTitle).bold()
                Text(article.content).font(.body).padding(.top, 10)
                Color.clear.frame(height: 1).onAppear {
                                        isAtEnd = true
                                    }
            }
            .padding()
            if isAtEnd && !isArticleRead{
                Button(action: {
                    isArticleRead = true
                    progressModel.increaseProgress(by: 5)
                }){
                    Text("Mark as Read")
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .navigationTitle(article.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}


