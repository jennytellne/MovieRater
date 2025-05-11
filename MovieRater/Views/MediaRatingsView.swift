//
//  MediaRatingsView.swift
//  MovieRater
//
//  Created by Jenny Tellne on 2025-05-11.
//

import SwiftUI
import SwiftData

struct MediaRatingsView: View {
    @Query private var mediaRatings: [MediaRating]

    var body: some View {
        VStack {
            List(mediaRatings, id: \.self.imdbID) { rating in
                NavigationLink {
                    MediaDetailsView(imdbID: rating.imdbID)
                } label: {
                    MediaRatingListItemView(mediaRating: rating)
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    MediaRatingsView()
}
