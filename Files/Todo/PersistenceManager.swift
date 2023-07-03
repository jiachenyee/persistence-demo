//
//  PersistenceManager.swift
//  Todo
//
//  Created by Jia Chen Yee on 03/07/23.
//

import Foundation

class PersistenceManager: ObservableObject {
    @Published var todos: [Todo] = [] {
        didSet {
            // Add an empty row at the end for the user to create another todo
            if !(todos.contains(where: { $0.title.isEmpty })) {
                todos.append(Todo(title: "", isCompleted: false))
            } else {
                writeTodos()
            }
        }
    }
    
    private let storageURL = URL.documentsDirectory.appending(path: "todos.json")
    
    init() {
        todos = readTodos()
    }
    
    func writeTodos() {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(todos)
        
        try? data?.write(to: storageURL)
    }
    
    func readTodos() -> [Todo] {
        guard let data = try? Data(contentsOf: storageURL) else {
            return [Todo(title: "", isCompleted: false)]
        }
        
        let decoder = JSONDecoder()
        let decodedTodos = try? decoder.decode([Todo].self, from: data)
        
        return decodedTodos ?? [Todo(title: "", isCompleted: false)]
    }
}
