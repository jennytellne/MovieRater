//
//  Errors.swift
//  MovieRater
//
//  Created by Jenny Tellne on 2025-05-08.
//

enum Errors: Error {
    case invalidUrl
    case requestFailed(Error)
    case clientError
    case serverError
    case decodingError(Error)
    case unknownError(Error)
}
