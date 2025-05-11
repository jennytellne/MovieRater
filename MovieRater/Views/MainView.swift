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
    @State private var isLoading: Bool = false
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
                
                ZStack {
                    TextField("Search for a movie or series", text: $searchText)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .background(Color.surface)
                        .cornerRadius(20)
                        .focused($isSearchFocused)
                        .submitLabel(.search)
                        .onSubmit {
                            activeSearchText = searchText
                            Task {
                                await fetchData()
                            }
                        }
                        .toolbar {
                            ToolbarItem(placement: .keyboard) {
                                HStack {
                                    Spacer()
                                    Button("Cancel") {
                                        searchText = activeSearchText
                                        isSearchFocused = false
                                    }
                                }
                                
                            }
                        }
                    if searchText != "" {
                        HStack {
                            Button {
                                clearSearch()
                            } label: {
                                ZStack {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundStyle(Color.appSecondary)
                                }
                                .frame(width: 44, height: 44)
                            }
                        }
                        .padding(.trailing, 5)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .padding([.horizontal, .bottom], 10)
                
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

// TODO: MVVM
extension MainView {
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
    
    private func clearSearch() {
        searchText = ""
        activeSearchText = ""
        searchResults = OMDBSearchResponseData()
    }
}

#Preview {
    MainView()
}
