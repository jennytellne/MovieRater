//
//  MovieRaterApp.swift
//  MovieRater
//
//  Created by Jenny Tellne on 2025-04-29.
//

import SwiftUI
import SwiftData

@main
struct MovieRaterApp: App {

    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: MediaRating.self)
    }
}
