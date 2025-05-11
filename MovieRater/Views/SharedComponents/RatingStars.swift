//
//  RatingStars.swift
//  MovieRater
//
//  Created by Jenny Tellne on 2025-05-11.
//

import SwiftUI

struct RatingStars: View {
    let rating: Int
    var body: some View {
        HStack {
            ForEach((1...5), id: \.self) { number in
                if number <= rating {
                    Image(systemName: "star.fill")
                        .font(.title)
                        .foregroundStyle(Color.yellow)
                } else {
                    Image(systemName: "star")
                        .font(.title)
                        .foregroundStyle(Color.black)
                }
            }
        }
    }
}

#Preview {
    RatingStars(rating: 3)
}
