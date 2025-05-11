//
//  ContentView.swift
//  MovieRater
//
//  Created by Jenny Tellne on 2025-04-29.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var searchResults: OMDBSearchResponseData = OMDBSearchResponseData()
    @State private var searchText: String = ""
    @State private var isLoading: Bool = false
    
    private let omdbService = OMDBService()
    
    var body: some View {
        NavigationStack {
            Text("Movie Rater")
                .font(.title)
                .padding(.top, 20)
                .padding(.bottom, 10)
            
            Form {
                NavigationLink {
                    NavigationStack {
                        MediaRatingsView()
                    }
                    .navigationTitle("Ratings")
                    .toolbarTitleDisplayMode(.large)
                    
                } label: {
                    Text("Your ratings")
                }
                .listRowBackground(Color.clear)
            }
            .scrollContentBackground(.hidden)
            .frame(height: 120)

            Spacer()
            
            Text("Search for a movie or series:")
            HStack {
                TextField("Test", text: $searchText)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    
                AsyncButton {
                    await fetchData()
                } label: {
                    Text("Search")
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .background(Color.black)
                .foregroundStyle(Color.white)
                .cornerRadius(5)

            }
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
            
            Spacer()
            
            if isLoading {
                ProgressView()
            } else {
                List(searchResults.Search ?? [], id: \.self.imdbID) { searchData in
                    NavigationLink {
                        MediaDetailsView(imdbID: searchData.imdbID)
                    } label: {
                        MediaListItemView(searchData: searchData)
                    }
                    // TODO: Add infinite scroll, fetch next page
                }
                .scrollContentBackground(.hidden)
            }
 
            Spacer()
            
        }
        .padding(.horizontal, 10)
    }
    
    private func fetchData() async {
        isLoading = true
        do {
            let responseData = try await omdbService.getBySearch(searchText)
            searchResults = responseData
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        isLoading = false
    }
}

#Preview {
    ContentView()
}
