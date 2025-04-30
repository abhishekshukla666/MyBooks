//
//  EditBookView.swift
//  MyBooks
//
//  Created by Encora on 28/04/25.
//

import SwiftUI

struct EditBookView: View {
    
    @Environment(\.dismiss) var dismiss
    let book: Book
    @State private var status = Status.onShelf
    @State private var rating: Int?
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var summary: String = ""
    @State private var dateAdded: Date = Date.distantPast
    @State private var dateStarted: Date = Date.distantPast
    @State private var dateFinished: Date = Date.distantPast
    @State private var firstView = true
    
    var body: some View {
        HStack {
            Text("Status")
            Picker("Status", selection: $status) {
                ForEach(Status.allCases) { status in
                    Text(status.description)
                        .tag(status)
                }
            }
            .buttonStyle(.bordered)
        }
        VStack(alignment: .leading) {
            GroupBox {
                LabeledContent {
                    DatePicker("", selection: $dateAdded, displayedComponents: .date)
                } label: {
                    Text("Date Added")
                }
                if status == .inProgress || status == .finished {
                    LabeledContent {
                        DatePicker("", selection: $dateStarted, in: dateAdded..., displayedComponents: .date)
                    } label: {
                        Text("Date Started")
                    }
                }
                if status == .finished {
                    LabeledContent {
                        DatePicker("", selection: $dateFinished, in: dateStarted..., displayedComponents: .date)
                    } label: {
                        Text("Date Finished")
                    }
                }
            }
            .foregroundStyle(.secondary)
            .onChange(of: status) { oldValue, newValue in
                if !firstView {
                    if newValue == .onShelf {
                        dateStarted = Date.distantPast
                        dateFinished = Date.distantPast
                    } else if newValue == .inProgress && oldValue == .finished {
                        dateFinished = Date.distantPast
                    } else if newValue == .inProgress && oldValue == .onShelf {
                        dateStarted = Date.now
                    } else if newValue == .finished && oldValue == .onShelf {
                        dateFinished = Date.now
                        dateStarted = dateAdded
                    } else {
                        dateFinished = Date.now
                    }
                    firstView = false
                }
            }
            Divider()
            LabeledContent {
                RatingsView(maxRating: 5, currentRating: $rating, width: 30)
            } label: {
                Text("Rating")
            }
            
            LabeledContent {
                TextField("", text: $title)
            } label: {
                Text("Title")
                    .foregroundStyle(.secondary)
            }
            LabeledContent {
                TextField("", text: $author)
            } label: {
                Text("Author")
                    .foregroundStyle(.secondary)
            }
            Divider()
            Text("Summary")
                .foregroundStyle(.secondary)
            TextEditor(text: $summary)
                .padding(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(uiColor: .tertiarySystemFill), lineWidth: 2)
                )
        }
        .padding()
        .textFieldStyle(.roundedBorder)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if changed {
                Button("Update") {
                    book.status = status.rawValue
                    book.rating = rating
                    book.title = title
                    book.author = author
                    book.summary = summary
                    book.dateAdded = dateAdded
                    book.dateStarted = dateStarted
                    book.dateFinished = dateFinished
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .onAppear {
            status = Status(rawValue: book.status)!
            title = book.title
            author = book.author
            summary = book.summary
            dateAdded = book.dateAdded
            dateStarted = book.dateStarted
            dateFinished = book.dateFinished
            rating = book.rating
            
        }
    }
    
    var changed: Bool {
        status != Status(rawValue: book.status)!
        || title != book.title
        || author != book.author
        || summary != book.summary
        || dateAdded != book.dateAdded
        || dateStarted != book.dateStarted
        || dateFinished != book.dateFinished
        || rating != book.rating
    }
}

#Preview {
    let preview = Preview(Book.self)
    return NavigationStack {
        EditBookView(book: Book.sampleBooks[2])
            .modelContainer(preview.container)
    }
}
