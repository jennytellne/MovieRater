//
//  MediaDetailsView.swift
//  MovieRater
//
//  Created by Jenny Tellne on 2025-05-09.
//

import SwiftUI

struct MediaDetailsView: View {
    let imdbID: String
    
    @State private var isLoading: Bool = false
    @State private var media: OMDBTitleIdResponseData = OMDBTitleIdResponseData()
    
    private let omdbService = OMDBService()

    var body: some View {
        VStack(alignment: .center) {
            ScrollView {
                Text(media.Title)
                    .font(.title)
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
                .foregroundStyle(Color.gray)
                
                AsyncImage(url: URL(string: media.Poster)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Color.purple
                }
                .frame(height: 400)
                .frame(maxWidth: .infinity)
                .clipShape(.rect(cornerRadius: 10))
                .padding(.vertical)
                
                Text(media.Plot)
                
                Spacer()
            }
            Spacer ()
            
            Button {
                // Ratings sheet
            } label: {
                Text("Rate \(media.Type)")
                    .frame(alignment: .center)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color.black)
                    .foregroundStyle(Color.white)
                    .cornerRadius(5)
            }
            

        }
        .padding(.top)
        .padding(.horizontal, 20)
        .task {
            await fetchData()
        }
    }
    
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
}

#Preview {
    MediaDetailsView(imdbID: "tt1517268")
}
