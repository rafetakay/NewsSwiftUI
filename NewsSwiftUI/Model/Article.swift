//
//  NewsResponse.swift
//  NewsSwiftUI
//
//  Created by Rafet Can AKAY on 3.02.2025.
//

import Foundation

import Foundation

//NewsResponse as an intermediary model is because the NewsAPI response wraps the list of articles inside a NewsResponse
struct NewsResponse: Codable {
    let status: String
    let articles: [Article]
    let totalResults : Int
}

struct Article: Identifiable, Codable {
    let id = UUID() // Unique identifier
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
}
