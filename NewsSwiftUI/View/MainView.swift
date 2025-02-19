//
//  MainView.swift
//  NewsSwiftUI
//
//  Created by Rafet Can AKAY on 3.02.2025.
//
import SwiftUI

struct MainView: View {
    
    @StateObject var newsVM = NewsViewModel()
    
    @Environment(\.apiKey) private var retrievedapiKeyFromEnv
      
    // State variables to track the selected country code and language
    @State private var selectedCountry: String = "us" // Default to "us" (United States)
    @State private var selectedLanguage: String = "en" // Default to "en" (English)
    
    // List of country codes and names
    let countries = [
        ("United States", "us"),
        ("Turkey", "tr"),
        ("United Kingdom", "gb"),
        ("Germany", "de"),
        ("France", "fr"),
        ("India", "in")
    ]
    
    // List of language codes and names
    let languages = [
        ("English", "en"),
        ("Turkish", "tr"),
        ("German", "de"),
        ("French", "fr"),
        ("Spanish", "es"),
        ("Italian", "it")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                
                Text("Your News")
                    .font(.title)
                    .foregroundColor(.blue)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)  // Align text to the left
                
                
                // Horizontal Stack for Country and Language Pickers
                HStack {
                    Picker("Select Country", selection: $selectedCountry) {
                        ForEach(countries, id: \.1) { country in
                            Text(country.0).tag(country.1)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    
                    Picker("Select Language", selection: $selectedLanguage) {
                        ForEach(languages, id: \.1) { language in
                            Text(language.0).tag(language.1)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    
                }
                .padding(.top)
                
                // Main content area with white background
                ZStack {
                    
                    Color.white.edgesIgnoringSafeArea(.all) // Set the background color to white
                                   
                    // Show the list if there are articles
                    if !newsVM.articles.isEmpty {
                    
                        VStack {
                            Text("Articles - Number : \(newsVM.articles.count)")
                                .font(.title2)
                                .foregroundColor(.blue)
                                .padding()
                            
                            List(newsVM.articles) { article in
                                NavigationLink(destination: SafariView(url: article.url)) {
                                    NewsArticleCell(article: article)  // Use the custom cell
                                }
                                .buttonStyle(PlainButtonStyle()) // Removes default NavigationLink styling (chevron)
                                .listRowSeparator(.hidden)       // Hides separators between cells
                                .listRowBackground(Color.clear)  // Ensures no unwanted background color
                                        
                            }
                            .listStyle(.plain) // Removes default separators
                            .scrollContentBackground(.hidden)
                            .background(Color.white)  
                        }
                    } else {
                        // Show a "No Data" label if there are no articles
                        VStack {
                                Spacer() // Push the content to the center
                                Text("No Data Available")
                                    .font(.title2)
                                    .foregroundColor(.gray)
                                    .padding()
                                           
                                Spacer() // Push the label to the center
                            }
                            .frame(maxHeight: .infinity) // Ensure this takes up the full height when no data
                    }
                }
            }
            .onAppear {
                newsVM.fetchNews(apikey: retrievedapiKeyFromEnv,forCountry: selectedCountry, andLanguage: selectedLanguage)
            }
            .onChange(of: selectedCountry) { newCountry in
                // Fetch news whenever the country selection changes
                newsVM.fetchNews(apikey: retrievedapiKeyFromEnv,forCountry: newCountry, andLanguage: selectedLanguage)
            }
            .onChange(of: selectedLanguage) { newLanguage in
                // Fetch news whenever the language selection changes
                newsVM.fetchNews(apikey: retrievedapiKeyFromEnv,forCountry: selectedCountry, andLanguage: newLanguage)
            }
            .toolbar {
                Button(action: {
                    newsVM.fetchNews(apikey: retrievedapiKeyFromEnv,forCountry: selectedCountry, andLanguage: selectedLanguage)
                }) {
                    Text("Get Latest News")
                }
            }
            .alert(isPresented: $newsVM.showAlert) {
                Alert(title: Text("No News Found"),
                      message: Text(newsVM.alertMessage),
                      dismissButton: .default(Text("OK")))
            }
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbarColorScheme(.light, for: .navigationBar)
        }
        .preferredColorScheme(.light)
    }
}

#Preview {
    MainView()
}
