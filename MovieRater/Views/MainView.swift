//
//  MainView.swift
//  MovieRater
//
//  Created by Jenny Tellne on 2025-04-29.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @State private var searchResults: OMDBSearchResponseData = OMDBSearchResponseData()
    @State private var searchText: String = ""
    @State private var activeSearchText: String = ""
    @FocusState private var isSearchFocused: Bool
    
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
                
                AnimatedSearchBar(searchResults: $searchResults, searchText: $searchText, activeSearchText: $activeSearchText, isSearchFocused: $isSearchFocused, hasActiveSearch: hasActiveSearch)
                
                Spacer()
                
                if hasActiveSearch {
                    MediaListView(results: searchResults.Search)
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

#Preview {
    MainView()
}
