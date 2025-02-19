//
//  WebService.swift
//  NewsSwiftUI
//
//  Created by Rafet Can AKAY on 3.02.2025.
//


import Foundation
import Alamofire


import Alamofire

class WebService {
    func getNews(downloadurl: String, completion: @escaping (Result<[Article], DownloaderError>) -> Void) {
        AF.request(downloadurl, method: .get)
            .validate()
            .responseDecodable(of: NewsResponse.self) { response in
                switch response.result {
                case .success(let newsResponse):
                    if newsResponse.totalResults > 0 {
                        completion(.success(newsResponse.articles))
                    } else {
                        completion(.failure(.noData))
                    }
                case .failure(let error):
                    print("Error fetching news: \(error)")
                    completion(.failure(.badUrl))
                }
            }
    }
}


enum DownloaderError: Error {
    case badUrl
    case noData
    case dataParseError
}

