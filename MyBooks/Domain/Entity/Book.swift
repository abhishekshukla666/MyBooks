//
//  Book.swift
//  MyBooks
//
//  Created by Encora on 28/04/25.
//

import SwiftUI
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var dateAdded: Date
    var dateStarted: Date
    var dateFinished: Date
    var summary: String
    var rating: Int?
    var status: Status.RawValue
    
    init(
        title: String,
        author: String,
        dateAdded: Date = Date.now,
        dateStarted: Date = Date.distantPast,
        dateFinished: Date = Date.distantPast,
        summary: String = "",
        rating: Int? = nil,
        status: Status = .onShelf
    ) {
        self.title = title
        self.author = author
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateFinished = dateFinished
        self.summary = summary
        self.rating = rating
        self.status = status.rawValue
    }
    
    var icon: Image {
        switch Status(rawValue: status)! {
        case .onShelf:
            return Image(systemName: "checkmark.diamond.fill")
        case .inProgress:
            return Image(systemName: "book.fill")
        case .finished:
            return Image(systemName: "books.vertical.fill")
        }
    }
}

enum Status: Int, Codable, Identifiable, CaseIterable {
    case onShelf, inProgress, finished
    var id: Self { self }
    
    var description: String {
        switch self {
        case .onShelf:
            return "On Shelf"
        case .inProgress:
            return "In Progress"
        case .finished:
            return "Finished"
        }
    }
}
