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
    
    var body: some View {
        HStack {
            Button {
                todo.isCompleted.toggle()
                try! viewContext.save()
            } label: {
                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
            }
            TextField("Title", text: Binding(get: {
                todo.title ?? ""
            }, set: { value in
                todo.title = value
                try! viewContext.save()
            }))
        }
    }
}

//struct TodoRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoRowView(todo: .constant(Todo(title: "Water plants",
//                                         isCompleted: false)))
//        .previewLayout(.sizeThatFits)
//    }
//}
