//
//  MediaListView.swift
//  MovieRater
//
//  Created by Jenny Tellne on 2025-05-11.
//

import SwiftUI

struct MediaListView: View {
    let results: [OMDBSearchData]?
    let totalResults: String
    var fetchData: () async -> Void

    var body: some View {
        List(Array((results ?? []).enumerated()), id: \.element.imdbID) { index, searchData in
            NavigationLink {
                MediaDetailsView(imdbID: searchData.imdbID)
            } label: {
                MediaListItemView(searchData: searchData)
                    .onAppear {
                        Task {
                            await loadMoreIfNeeded(index: index)
                        }
                    }
            }
        }
        .scrollContentBackground(.hidden)
        .listStyle(.plain)
    }
}

extension MediaListView {
    private func loadMoreIfNeeded(index: Int) async {
        if let results, index == results.count - 1,
           results.count < Int(totalResults) ?? 0 {
            await fetchData()
        }
    }
}

#Preview {
    let results = [OMDBSearchData(Title: "Barbie", Year: "2023", imdbID: "tt1517268", Type: "movie", Poster: "https://m.media-amazon.com/images/M/MV5BYjI3NDU0ZGYtYjA2YS00Y2RlLTgwZDAtYTE2YTM5ZjE1M2JlXkEyXkFqcGc@._V1_SX300.jpg")]
    MediaListView(results: results, totalResults: "10") {
        
    }
}
