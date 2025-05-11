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
                                searchText = ""
                                activeSearchText = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(Color.appSecondary)
                            }
                        }
                        .padding(.trailing, 15)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .padding([.horizontal, .bottom], 10)
                
                Spacer()
                
                if hasActiveSearch {
                    List(searchResults.Search ?? [], id: \.self.imdbID) { searchData in
                        NavigationLink {
                            MediaDetailsView(imdbID: searchData.imdbID)
                        } label: {
                            MediaListItemView(searchData: searchData)
                        }
                        // TODO: Add infinite scroll, fetch next page
                    }
                    .scrollContentBackground(.hidden)
                } else {
                        MediaRatingsView()
                }
                Spacer()
            }
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
    MainView()
}
