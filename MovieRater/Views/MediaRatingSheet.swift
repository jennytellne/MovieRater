//
//  MediaRatingSheet.swift
//  MovieRater
//
//  Created by Jenny Tellne on 2025-05-10.
//

import SwiftUI

struct MediaRatingSheet: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    let imdbID: String
    let title: String
    let poster: String
    @Binding var currentRating: MediaRating?
    
    @State private var rating: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                ForEach((1...5), id: \.self) { number in
                    Button {
                        rating = number
                    } label: {
                        if number <= rating {
                            Image(systemName: "star.fill")
                                .font(.title)
                                .foregroundStyle(Color.yellow)
                        } else {
                            Image(systemName: "star")
                                .font(.title)
                                .foregroundStyle(Color.black)
                        }
                        
                    }
                }
            }
        }
        .presentationDetents([.height(200)])
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    do {
                        if let currentRating {
                            try updateRating(currentRating, newRating: rating)
                        } else {
                            try addRating(imdbID: imdbID, rating: rating)
                        }
                    } catch {
                        print("Error adding/updating rating: \(error.localizedDescription)")
                    }
                    dismiss()
                }
            }
        }
        .onAppear {
            if let currentRating {
                rating = currentRating.rating
            }
        }
    }
}

// TODO: MVVM
extension MediaRatingSheet {
    func addRating(imdbID: String, rating: Int) throws {
        if rating < 0, rating > 10 {
            throw Errors.invalidRating
        } else if imdbID == "" {
            throw Errors.missingId
        }
        
        modelContext.insert(MediaRating(imdbID: imdbID, title: title, poster: poster, rating: rating))
        do {
            try modelContext.save()
        } catch {
            print("Error saving rating: \(error.localizedDescription)")
            throw Errors.saveRatingError
        }
    }
    
    func updateRating(_ item: MediaRating, newRating: Int) throws {
        if newRating < 0, newRating > 10 {
            throw Errors.invalidRating
        }
        
        item.rating = newRating
        do {
            try modelContext.save()
        } catch {
            print("Error updating rating: \(error.localizedDescription)")
            throw Errors.updateRatingError
        }
    }
}

#Preview {
    @Previewable @State var currentRating: MediaRating? = MediaRating(imdbID: "tt1517268", title: "Barbie", poster: "tt1517268", rating: 4)
    MediaRatingSheet(imdbID: "tt1517268", title: "Barbie", poster: "tt1517268", currentRating: $currentRating)
}
