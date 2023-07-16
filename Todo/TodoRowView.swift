//
//  TodoRowView.swift
//  Todo
//
//  Created by Jia Chen Yee on 03/07/23.
//

import SwiftUI
import CoreData

struct TodoRowView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var todo: Todo
    
    @State private var isInfoPresented = false
    
    var body: some View {
        HStack {
            Button {
                todo.isCompleted.toggle()
                try! viewContext.save()
            } label: {
                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
            }
            .buttonStyle(.plain)
            
            TextField("Title", text: Binding(get: {
                todo.title ?? ""
            }, set: { value in
                todo.title = value
                try! viewContext.save()
            }))
            
            Button {
                isInfoPresented = true
            } label: {
                Image(systemName: "info.circle")
            }
        }
        .sheet(isPresented: $isInfoPresented) {
            TodoInfoView(todo: todo)
        }
    }
}
