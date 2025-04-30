//
//  NewBookView.swift
//  MyBooks
//
//  Created by Encora on 28/04/25.
//

import SwiftUI

struct NewBookView: View {
    
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @State private var title: String = ""
    @State private var author: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Book Title", text: $title)
                TextField("Book Author", text: $author)
                Button("Create") {
                    let newBook = Book(title: title, author: author)
                    context.insert(newBook)
                    dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .buttonStyle(.borderedProminent)
                .padding(.vertical)
                .disabled(title.isEmpty || author.isEmpty)
                .navigationTitle("Add New Book")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
            }
        }
        
    }
}
