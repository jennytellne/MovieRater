//
//  MediaListItemView.swift
//  MovieRater
//
//  Created by Jenny Tellne on 2025-05-09.
//

import SwiftUI

struct MediaListItemView: View {
    let searchData: OMDBSearchData
    var body: some View {
        HStack(alignment: .top) {
            PosterImage(posterUrlString: searchData.Poster)
                .frame(width: 70, height: 120)
                .clipShape(.rect(cornerRadius: 10))
            
            VStack(alignment: .leading) {
                Text(searchData.Title)
                    .font(.headline)
                    .fontWeight(.bold)
                Text(searchData.Type)
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                Text(searchData.Year)
                    .font(.subheadline)
                
                Spacer()
            }
            .padding(.leading, 5)
            .frame(height: 80)
            
            Spacer()
        }
    }
}

#Preview {
    MediaListItemView(searchData: OMDBSearchData())
}
