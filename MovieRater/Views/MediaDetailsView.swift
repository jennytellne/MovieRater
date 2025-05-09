//
//  MediaDetailsView.swift
//  MovieRater
//
//  Created by Jenny Tellne on 2025-05-09.
//

import SwiftUI

struct MediaDetailsView: View {
    let searchData: OMDBSearchData
    var body: some View {
        ScrollView {
            Text(searchData.Title)
                .font(.title)
            AsyncImage(url: URL(string: searchData.Poster)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Color.purple
            }
            .frame(height: 400)
            .frame(maxWidth: .infinity)
            .clipShape(.rect(cornerRadius: 10))
            .padding()
            
            Spacer()
        }
        .padding(.top)
    }
}

#Preview {
    MediaDetailsView(searchData: OMDBSearchData(Title: "Test", Year: "2016", imdbID: "kfsdlfkns", Type: "movie", Poster: ""))
}
