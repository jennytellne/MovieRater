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
        VStack(alignment: .leading) {
            Text("My ratings")
                .font(.caption)
                .foregroundStyle(Color.primaryText)
            if mediaRatings.count > 0 {
                List(mediaRatings, id: \.self.imdbID) { rating in
                    NavigationLink {
                        MediaDetailsView(imdbID: rating.imdbID)
                    } label: {
                        MediaRatingListItemView(mediaRating: rating)
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
            } else {
                VStack {
                    Text("No ratings yet")
                        .font(.title)
                        .foregroundStyle(Color.primaryText)
                        .padding(.bottom)
                    Text("Look up movies and series that you have watched and give them a rating!")
                        .foregroundStyle(Color.primaryText)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 40)
                .frame(maxWidth: .infinity)
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    MediaRatingsView()
}
