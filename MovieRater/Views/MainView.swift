//
//  MainView.swift
//  MovieRater
//
//  Created by Jenny Tellne on 2025-04-29.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @State private var searchResults: [OMDBSearchData] = []
    @State private var searchText: String = ""
    @State private var activeSearchText: String = ""
    @FocusState private var isSearchFocused: Bool
    @State private var pageNumber: Int = 1
    @State private var totalResults: String = ""
    @State private var invalidSearchInfo: String = ""
        
    private var hasActiveSearch: Bool {
        return isSearchFocused || searchText != ""
    }
    private let omdbService = OMDBService()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Movie Rater")
                    .font(.largeTitle)
                    .padding(.top, 20)
                    .padding([.bottom, .leading], 10)
                
                AnimatedSearchBar(searchResults: $searchResults, searchText: $searchText, activeSearchText: $activeSearchText, isSearchFocused: $isSearchFocused, hasActiveSearch: hasActiveSearch) {
                    await fetchData()
                } clearSearch: {
                    clearSearch()
                }
                
                Spacer()
                
                if hasActiveSearch {
                    if invalidSearchInfo != "" {
                        VStack {
                            Text(invalidSearchInfo)
                                .padding(.leading)
                            Spacer()
                        }
                    } else {
                        if activeSearchText != "", searchResults.count > 0 {
                            Text("\(totalResults) results for \"\(activeSearchText)\"")
                                .foregroundColor(Color.secondaryText)
                                .padding([.leading, .bottom])
                            MediaListView(results: searchResults, totalResults: totalResults) {
                                await fetchData()
                            }
                        }
                    }
                } else {
                    MediaRatingsView()
                }
                Spacer()
            }
        }
        .padding(.horizontal, 10)
        .tint(Color.accent)
    }
}

extension MainView {
    private func clearSearchResults() {
        totalResults = ""
        invalidSearchInfo = ""
        searchResults = []
        pageNumber = 1
    }
    
    private func fetchData() async {
        invalidSearchInfo = ""
        do {
            let responseData = try await omdbService.getBySearch(searchText, page: pageNumber)
            if responseData.Response.lowercased() == "true" {
                totalResults = responseData.totalResults ?? "0"
                searchResults.append(contentsOf:  responseData.Search ?? [])
            } else {
                invalidSearchInfo = responseData.Error ?? ""
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        pageNumber += 1
    }
    
    private func clearSearch() {
        searchText = ""
        activeSearchText = ""
        clearSearchResults()
    }
}

#Preview {
    MainView()
}
