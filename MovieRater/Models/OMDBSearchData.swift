//
//  OMDBSearchData.swift
//  MovieRater
//
//  Created by Jenny Tellne on 2025-05-06.
//

struct OMDBSearchData: Codable {
    let Title: String
    let Year: String
    let imdbID: String
    let `Type`: OMDBType
    let Poster: String
}
