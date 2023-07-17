//
//  ContentView.swift
//  Todo
//
//  Created by Jia Chen Yee on 03/07/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Todo.creationDate, ascending: true)],
                  predicate: NSPredicate(format: "isCompleted == true"),
                  animation: .default)
    private var doneTodos: FetchedResults<Todo>
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Todo.creationDate, ascending: true)],
                  predicate: NSPredicate(format: "isCompleted == false"),
                  animation: .default)
    private var undoneTodos: FetchedResults<Todo>
    
    // TODO: Save username
    @State private var username = ""
    @State private var isOnboardingPresented = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Incomplete") {
                    ForEach(undoneTodos) { todo in
                        TodoRowView(todo: todo)
                    }
                    .onDelete {
                        deleteItems(todos: undoneTodos, offsets: $0)
                    }
                }
                
                Section("Completed") {
                    ForEach(doneTodos) { todo in
                        TodoRowView(todo: todo)
                    }
                    .onDelete {
                        deleteItems(todos: doneTodos, offsets: $0)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("\(username)'s Todos")
        }
        .onAppear {
            if username.isEmpty {
                isOnboardingPresented = true
            }
        }
        .sheet(isPresented: $isOnboardingPresented) {
            OnboardingView(username: $username)
                .interactiveDismissDisabled()
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Todo(context: viewContext)
            newItem.creationDate = Date.now
            newItem.title = ""
            newItem.isCompleted = false
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(todos: FetchedResults<Todo>, offsets: IndexSet) {
        withAnimation {
            offsets.map { todos[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
