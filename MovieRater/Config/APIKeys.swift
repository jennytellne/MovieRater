//
//  APIKeys.swift
//  MovieRater
//
//  Created by Jenny Tellne on 2025-05-06.
//

import Foundation

public enum APIKeys {
    enum Keys {
        static let OMBDApiKey = "OMDB_API_KEY"
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist file not found")
        }
        return dict
    }()
    
    static let OMBDApiKey: String = {
        guard let OMBDApiKeyString = APIKeys.infoDictionary[Keys.OMBDApiKey] as? String else {
            fatalError("OMDB API Key not set in plist")
        }
        return OMBDApiKeyString
    }()
}
