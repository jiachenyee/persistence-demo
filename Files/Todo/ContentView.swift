//
//  ContentView.swift
//  Todo
//
//  Created by Jia Chen Yee on 03/07/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var persistenceManager = PersistenceManager()
    
    var body: some View {
        NavigationStack {
            List($persistenceManager.todos, editActions: .all) { $todo in
                TodoRowView(todo: $todo)
            }
            .navigationTitle("Todos")
            .toolbar {
                EditButton()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
