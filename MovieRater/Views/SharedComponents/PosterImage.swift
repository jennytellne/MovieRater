//
//  PosterImage.swift
//  MovieRater
//
//  Created by Jenny Tellne on 2025-05-11.
//

import SwiftUI

struct PosterImage: View {
    let posterUrlString: String
    
    var body: some View {
        AsyncImage(url: URL(string: posterUrlString)) { image in
            image.resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            ZStack {
                Color.gray
                Image(systemName: "exclamationmark.square.fill")
            }
        }
    }
}

#Preview {
    PosterImage(posterUrlString: "")
}
