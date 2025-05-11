//
//  MediaListView.swift
//  MovieRater
//
//  Created by Jenny Tellne on 2025-05-11.
//

import SwiftUI

struct MediaListView: View {
    let results: [OMDBSearchData]?
    var body: some View {
        List(results ?? [], id: \.self.imdbID) { searchData in
            NavigationLink {
                MediaDetailsView(imdbID: searchData.imdbID)
            } label: {
                MediaListItemView(searchData: searchData)
            }
            // TODO: Add infinite scroll, fetch next page
        }
        .scrollContentBackground(.hidden)
        .listStyle(.plain)
    }
}

#Preview {
    let results = [OMDBSearchData(Title: "Barbie", Year: "2023", imdbID: "tt1517268", Type: "movie", Poster: "https://m.media-amazon.com/images/M/MV5BYjI3NDU0ZGYtYjA2YS00Y2RlLTgwZDAtYTE2YTM5ZjE1M2JlXkEyXkFqcGc@._V1_SX300.jpg")]
    MediaListView(results: results)
}
