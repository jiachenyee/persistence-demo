//
//  ContentView.swift
//  Todo
//
//  Created by Jia Chen Yee on 03/07/23.
//

import SwiftUI
import Forever

struct ContentView: View {
    
    @Forever("todos") var todos: [Todo] = [Todo(title: "", isCompleted: false)]
    
    var body: some View {
        NavigationStack {
            List($todos, editActions: .all) { $todo in
                TodoRowView(todo: $todo)
            }
            .navigationTitle("Todos")
            .toolbar {
                EditButton()
            }
            .onChange(of: todos) { newValue in
                if !(newValue.contains(where: { $0.title.isEmpty })) {
                    withAnimation {
                        todos.append(Todo(title: "", isCompleted: false))
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
