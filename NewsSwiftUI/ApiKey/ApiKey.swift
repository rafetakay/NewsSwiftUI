//
//  ApiKey.swift
//  NewsSwiftUI
//
//  Created by Rafet Can AKAY on 3.02.2025.
//

import SwiftUI

private struct APIKeyEnvironmentKey: EnvironmentKey {
    static let defaultValue: String = "YOUR_API_KEY" 
}

extension EnvironmentValues {
    var apiKey: String {
        get { self[APIKeyEnvironmentKey.self] }
        set { self[APIKeyEnvironmentKey.self] = newValue }
    }
}
