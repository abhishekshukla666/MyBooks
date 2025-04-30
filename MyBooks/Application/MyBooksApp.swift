//
//  MyBooksApp.swift
//  MyBooks
//
//  Created by Encora on 28/04/25.
//

import SwiftUI
import SwiftData

@main
struct MyBooksApp: App {
    
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            BookListView()
        }
        ///
        ///.modelContainer(Book.self)
        .modelContainer(container)
    }
    
    init() {
        /// 3rd Type
        let schema = Schema([Book.self])
        let configuration = ModelConfiguration("MyBooks", schema: schema)
        do {
            container = try ModelContainer(for: schema, configurations: configuration)
        } catch {
            fatalError("Could not configure the container")
        }
        
        /// 2nd Type
//        let configuration = ModelConfiguration(url: URL.documentsDirectory.appending(path: "MyBookds.store"))
//        do {
//            container = try ModelContainer(for: Book.self, configurations: configuration)
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
//        print(URL.documentsDirectory.path)
    }
}
