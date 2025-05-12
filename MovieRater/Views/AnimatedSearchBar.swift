//
//  AnimatedSearchBar.swift
//  MovieRater
//
//  Created by Jenny Tellne on 2025-05-11.
//

import SwiftUI

struct AnimatedSearchBar: View {
    @Binding var searchResults: [OMDBSearchData]
    @Binding var searchText: String
    @Binding var activeSearchText: String
    @FocusState.Binding var isSearchFocused: Bool
    var hasActiveSearch: Bool
    var fetchData: () async -> Void
    var clearSearch: () -> Void
    
    var body: some View {
        HStack {
            if hasActiveSearch {
                Button {
                    clearSearch()
                    isSearchFocused = false
                } label: {
                    ZStack {
                        Color.clear
                            .frame(width: 44, height: 44)
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .fontWeight(.bold)
                            .transition(.move(edge: .leading).combined(with: .opacity))
                    }
                    .padding(.horizontal, -5)
                    
                }
                
            }
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
        }
        .padding([.horizontal, .bottom], 10)
        .animation(.easeInOut, value: hasActiveSearch)
    }
}

#Preview {
    @Previewable @State var searchResults: [OMDBSearchData] = []
    @Previewable @State var searchText = ""
    @Previewable @State var activeSearchText = ""
    @Previewable @FocusState var isSearchFocused
    @Previewable @State var hasActiveSearch = true
    
    AnimatedSearchBar(searchResults: $searchResults, searchText: $searchText, activeSearchText: $activeSearchText, isSearchFocused: $isSearchFocused, hasActiveSearch: hasActiveSearch) { } clearSearch: {
    }
}
