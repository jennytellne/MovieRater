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
    let `Type`: String
    let Poster: String
    
    init() {
        Title = ""
        Year = ""
        imdbID = ""
        `Type` = ""
        Poster = ""
    }
    
    init(
        Title: String,
        Year: String,
        imdbID: String,
        `Type`: String,
        Poster: String
    ) {
        self.Title = Title
        self.Year = Year
        self.imdbID = imdbID
        self.`Type` = `Type`
        self.Poster = Poster
    }
}
