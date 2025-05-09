//
//  OMDBService.swift
//  MovieRater
//
//  Created by Jenny Tellne on 2025-05-06.
//

import Foundation

class OMDBService {
    private let apiKey = APIKeys.OMBDApiKey
    private let baseUrlString = "https://www.omdbapi.com/?"
    
    func getBySearch(_ search: String) async throws -> OMDBSearchResponseData {
        guard let url = URL(string: baseUrlString + "apiKey=\(apiKey)&s=\(search)") else {
            print("Error: invalid url")
            throw Errors.invalidUrl
        }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let response = response as? HTTPURLResponse {
                if response.statusCode >= 400 && response.statusCode < 500 {
                    throw Errors.clientError
                } else if response.statusCode >= 500 && response.statusCode < 600 {
                    throw Errors.serverError
                }
            }
            return try decodeSearchResponse(data)
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
            throw Errors.requestFailed(error)
        }
    }
    
    private func decodeSearchResponse(_ data: Data) throws -> OMDBSearchResponseData {
        do {
            let response = try JSONDecoder().decode(OMDBSearchResponseData.self, from: data)
            return response
        } catch {
            print("Error decoding data: \(error.localizedDescription)")
            throw Errors.decodingError(error)
        }
    }
}
