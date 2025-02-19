//
//  ArticleCell.swift
//  NewsSwiftUI
//
//  Created by Rafet Can AKAY on 3.02.2025.
//

import SwiftUI

// Custom cell for displaying article title and image
struct NewsArticleCell: View {
    var article: Article  // Data for the article passed to the custom cell
    
    var body: some View {
        HStack {
            // Image on the left side of the cell
            if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 60, height: 60)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(Circle())
                    case .success(let image):
                        image.resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                    case .failure:
                        Image(systemName: "photo")
                            .frame(width: 60, height: 60)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(Circle())
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                // Placeholder for missing images
                Image(systemName: "photo")
                    .frame(width: 60, height: 60)
                    .background(Color.gray.opacity(0.3))
                    .clipShape(Circle())
            }
            
            // Article title on the right side
            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(3)
                    .foregroundColor(.black)
                    .padding(.leading, 10)
            }
            .frame(maxWidth: .infinity, alignment: .leading) // Takes full width
                
        }
        .padding()
        .frame(maxWidth: .infinity) // HStack takes full width
        .background(Color.green)  // Custom background for the cell
        .cornerRadius(10)  // Rounded corners
        .shadow(radius: 5)  // Shadow for the cell
        .padding(.horizontal, 5) // Makes width equal to screen width - 70
           
    }
}


