//
//  ArticleModel.swift
//  FigITMobile
//
//  Created by Charmaine Suah on 13/11/2024.
//

import Foundation

struct Article : Identifiable{
    let id = UUID()
    let title: String
    let summary: String
    let content: String
}
