//
//  OMDBSearchResponseData.swift
//  MovieRater
//
//  Created by Jenny Tellne on 2025-05-06.
//

struct OMDBSearchResponseData: Codable {
    let Response: String
    let Search: [OMDBSearchData]?
    let totalResults: String?
    let Error: String?
}
