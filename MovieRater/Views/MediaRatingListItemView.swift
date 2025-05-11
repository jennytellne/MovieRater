//
//  MediaRatingListItemView.swift
//  MovieRater
//
//  Created by Jenny Tellne on 2025-05-11.
//

import SwiftUI
import SwiftData

struct MediaRatingListItemView: View {
    let mediaRating: MediaRating
    var body: some View {
        HStack(alignment: .top) {
            PosterImage(posterUrlString: mediaRating.poster)
                .frame(width: 70, height: 120)
                .clipShape(.rect(cornerRadius: 10))
            
            VStack(alignment: .leading) {
                Text(mediaRating.title)
                    .font(.headline)
                    .fontWeight(.bold)
                RatingStars(rating: mediaRating.rating)
                Spacer()
            }
            .padding(.leading, 5)
            .frame(height: 80)
            
            Spacer()
        }
    }
}

#Preview {
    let rating = MediaRating(imdbID: "tt1517268", title: "Barbie", poster: "tt1517268", rating: 4)
    MediaRatingListItemView(mediaRating: rating)
}
