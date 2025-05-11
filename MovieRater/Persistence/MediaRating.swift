//
//  Item.swift
//  MovieRater
//
//  Created by Jenny Tellne on 2025-04-29.
//

import Foundation
import SwiftData

@Model
final class MediaRating {
    var imdbID: String
    var title: String
    var poster: String
    var rating: Int
    
    init(imdbID: String, title: String, poster: String, rating: Int) {
        self.imdbID = imdbID
        self.title = title
        self.poster = poster
        self.rating = rating
    }
}
