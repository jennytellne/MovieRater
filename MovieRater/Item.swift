//
//  Item.swift
//  MovieRater
//
//  Created by Jenny Tellne on 2025-04-29.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
