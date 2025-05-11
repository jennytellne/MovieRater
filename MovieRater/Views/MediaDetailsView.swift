//
//  MediaDetailsView.swift
//  MovieRater
//
//  Created by Jenny Tellne on 2025-05-09.
//

import SwiftUI
import SwiftData

struct MediaDetailsView: View {
    @Query private var mediaRatings: [MediaRating]
    
    let imdbID: String
    
    @State private var isLoading: Bool = false
    @State private var isPresentingRatingView: Bool = false
    @State private var media: OMDBTitleIdResponseData = OMDBTitleIdResponseData()
    @State private var mediaRating: MediaRating?
    
    private let omdbService = OMDBService()

    var body: some View {
        VStack(alignment: .center) {
            ScrollView {
                HStack {
                    Text(media.Type)
                    HorizontalDivider()
                    Text(media.Year)
                    HorizontalDivider()
                    Text(media.Rated)
                    HorizontalDivider()
                    Text(media.Runtime)
                }
                .font(.subheadline)
                .foregroundStyle(Color.secondaryText)
                
                PosterImage(posterUrlString: media.Poster)
                .frame(height: 400)
                .frame(maxWidth: .infinity)
                .clipShape(.rect(cornerRadius: 10))
                .padding(.vertical)
                
                if let mediaRating {
                    Text("Your rating: ")
                        .font(.caption)
                        .foregroundStyle(Color.secondaryText)
                        .padding(.bottom, 5)
                    RatingStars(rating: mediaRating.rating)
                        .font(.title)
                        .padding(.bottom)
                } else {
                    Text("You have not rated this \(media.Type) yet")
                        .font(.caption)
                        .foregroundStyle(Color.secondaryText)
                        .padding(.bottom)
                }
                
                Text(media.Plot)
                    .foregroundStyle(Color.primaryText)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
        }
        .navigationTitle(media.Title)
        .navigationBarTitleDisplayMode(.large)
        .padding(.top)
        .padding(.horizontal, 20)
        .task {
            fetchMoiveRating(for: imdbID)
            await fetchData()
        }
        .toolbar {
            Button("Rate") {
                isPresentingRatingView = true
            }
        }
        .sheet(isPresented: $isPresentingRatingView, onDismiss: {
            fetchMoiveRating(for: imdbID)
        }, content: {
            NavigationStack {
                MediaRatingSheet(imdbID: imdbID, title: media.Title, poster: media.Poster, currentRating: $mediaRating)
                    .navigationTitle("Rate \(media.Type)")
            }
        })
    }
}

// TODO: MVVM
extension MediaDetailsView {
    private func fetchData() async {
        isLoading = true
        do {
            let responseData = try await omdbService.getById(imdbID)
            media = responseData
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        isLoading = false
    }
    
    func fetchMoiveRating(for imdbID: String) {
        if let rating = mediaRatings.first(where: { $0.imdbID == imdbID }) {
            print("Rating: \(rating.rating)")
            mediaRating = rating
        }
    }
}

#Preview {
    MediaDetailsView(imdbID: "tt1517268")
}
