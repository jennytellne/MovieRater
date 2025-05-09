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
    let Actors: String
    let Plot: String
    let Poster: String
    let imdbRating: String
    let imdbID: String
    let `Type`: String
    let Response: String
    
    init() {
        Title = ""
        Year = ""
        Rated = ""
        Released = ""
        Runtime = ""
        Genre = ""
        Actors = ""
        Plot = ""
        Poster = ""
        imdbRating = ""
        imdbID = ""
        `Type` = ""
        Response = ""
    }
    
    init(
        Title: String,
        Year: String,
        Rated: String,
        Released: String,
        Runtime: String,
        Genre: String,
        Actors: String,
        Plot: String,
        Poster: String,
        imdbRating: String,
        imdbID: String,
        `Type`: String,
        Response: String
    ) {
        self.Title = Title
        self.Year = Year
        self.Rated = Rated
        self.Released = Released
        self.Runtime = Runtime
        self.Genre = Genre
        self.Actors = Actors
        self.Plot = Plot
        self.Poster = Poster
        self.imdbRating = imdbRating
        self.imdbID = imdbID
        self.`Type` = `Type`
        self.Response = Response
    }
}
