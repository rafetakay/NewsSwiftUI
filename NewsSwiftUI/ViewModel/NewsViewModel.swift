//
//  NewsViewModel.swift
//  NewsSwiftUI
//
//  Created by Rafet Can AKAY on 3.02.2025.
//

import Foundation
import Alamofire
import Foundation
import Alamofire

class NewsViewModel: ObservableObject {
    
    //it publish here and subscribed at main view , when it changed subscriber will update
    @Published var articles: [Article] = []
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    let webService = WebService()

    func fetchNews(apikey: String,forCountry countryCode: String, andLanguage languageCode: String) {
           // Build the URL with the selected country and language codes
       
        let geturl = "https://newsapi.org/v2/top-headlines?country=\(countryCode)&language=\(languageCode)&apiKey=\(apikey)"
           
           webService.getNews(downloadurl: geturl) { result in
               switch result {
               case .success(let fetchedArticles):
                   if fetchedArticles.isEmpty {
                       // Clear articles array if no data is received
                       self.articles = []
                       self.showAlert = true
                       self.alertMessage = "No articles found."
                   } else {
                       self.articles = fetchedArticles
                   }
               case .failure(let error):
                   // Handle error and show alert
                   self.showAlert = true
                   self.articles = []
                   self.alertMessage = "Failed to fetch data: \(error)"
               }
           }
       }
}


