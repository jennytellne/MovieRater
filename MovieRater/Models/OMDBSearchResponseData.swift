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
    
    init() {
        Response = ""
        Search = []
        totalResults = ""
        Error = nil
    }
    
    init(Response: String, Search: [OMDBSearchData]?, totalResults: String?, Error: String?) {
        self.Response = Response
        self.Search = Search
        self.totalResults = totalResults
        self.Error = Error
    }
}
