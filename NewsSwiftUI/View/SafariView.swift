//
//  SafariView.swift
//  NewsSwiftUI
//
//  Created by Rafet Can AKAY on 3.02.2025.
//

import Foundation
import SwiftUI
import SafariServices


struct SafariView: View {
    var url: String
    
    var body: some View {
        if let validURL = URL(string: url) {
            SafariViewController(url: validURL)
        } else {
            Text("Invalid URL")
        }
    }
}

// SafariViewController to handle the safari browsing
struct SafariViewController: UIViewControllerRepresentable {
    var url: URL
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let safariVC = SFSafariViewController(url: url)
        return safariVC
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
