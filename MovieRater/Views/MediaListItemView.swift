//
//  MediaListItemView.swift
//  MovieRater
//
//  Created by Jenny Tellne on 2025-05-09.
//

import SwiftUI
import SwiftData

struct MediaListItemView: View {
    @Query private var mediaRatings: [MediaRating]

    let searchData: OMDBSearchData
    
    @State private var mediaRating: MediaRating?

    var body: some View {
  
        HStack(alignment: .top) {
            PosterImage(posterUrlString: searchData.Poster)
                .frame(width: 70, height: 120)
                .clipShape(.rect(cornerRadius: 10))
            
            VStack(alignment: .leading) {
                Text(searchData.Title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.top, 2)
                Text(searchData.Type)
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                Text(searchData.Year)
                    .font(.subheadline)
                
                if let mediaRating {
                    RatingStars(rating: mediaRating.rating)
                        .padding(.top, 2)
                }
                Spacer()
            }
            .padding(.leading, 5)
            
            Spacer()
        }
        .frame(minHeight: 120)
        .task {
            fetchMediaRating(for: searchData.imdbID)
        }
    }
}

extension MediaListItemView {
    func fetchMediaRating(for imdbID: String) {
        if let rating = mediaRatings.first(where: { $0.imdbID == imdbID }) {
            mediaRating = rating
        }
    }
}

#Preview {
    MediaListItemView(searchData: OMDBSearchData())
}
