//
//  PreviewContainer.swift
//  MyBooks
//
//  Created by Encora on 28/04/25.
//

import SwiftData

struct Preview {
    let container: ModelContainer
    init(_ models: any PersistentModel.Type...) {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let schema = Schema(models)
        do {
            container = try ModelContainer(for: schema, configurations: configuration)
        } catch {
            fatalError("Could not create container: \(error)")
        }
    }
    
    
    func addExamples(_ examples: [any PersistentModel]) {
        Task { @MainActor in
            examples.forEach { example in
                container.mainContext.insert(example)
            }
        }
    }
}
