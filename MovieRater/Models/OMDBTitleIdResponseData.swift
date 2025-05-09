//
//  OMDBTitleIdResponseData.swift
//  MovieRater
//
//  Created by Jenny Tellne on 2025-05-06.
//

struct OMDBTitleIdResponseData: Codable {
    let Title: String
    let Year: String
    let Rated: String
    let Released: String
    let Runtime: String
    let Genre: String
    let Director: String
    let Writer: String
    let Actors: String
    let Plot: String
    let Language: String
    let Country: String
    let Awards: String
    let Poster: String
    let Ratings: [OMDBRating]
    let Metascore: String
    let imdbRating: String
    let imdbVotes: String
    let imdbId: String
    let `Type`: String
    let DVD: String
    let BoxOffice: String
    let Production: String
    let Website: String
    let Response: String
}
