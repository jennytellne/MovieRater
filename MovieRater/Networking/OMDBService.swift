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
    
    func getBySearch(_ search: String, page: Int) async throws -> OMDBSearchResponseData {
        let cleanedSearch = search.replacingOccurrences(of: "&", with: "%26").replacingOccurrences(of: " ", with: "+")
        guard let url = URL(string: baseUrlString + "apiKey=\(apiKey)&s=\(cleanedSearch)&page=\(page)") else {
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
    
    func getById(_ id: String) async throws -> OMDBTitleIdResponseData {
        guard let url = URL(string: baseUrlString + "apiKey=\(apiKey)&i=\(id)&plot=full") else {
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
            return try decodeIdResponse(data)
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
    
    private func decodeIdResponse(_ data: Data) throws -> OMDBTitleIdResponseData {
        do {
            let response = try JSONDecoder().decode(OMDBTitleIdResponseData.self, from: data)
            return response
        } catch {
            print("Error decoding data: \(error.localizedDescription)")
            throw Errors.decodingError(error)
        }
    }
}
