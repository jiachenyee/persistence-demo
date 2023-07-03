//
//  TodoRowView.swift
//  Todo
//
//  Created by Jia Chen Yee on 03/07/23.
//

import SwiftUI

struct TodoRowView: View {
    
    @Binding var todo: Todo
    
    var body: some View {
        HStack {
            Button {
                todo.isCompleted.toggle()
            } label: {
                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
            }
            TextField("Title", text: $todo.title)
        }
    }
}

struct TodoRowView_Previews: PreviewProvider {
    static var previews: some View {
        TodoRowView(todo: .constant(Todo(title: "Water plants",
                                         isCompleted: false)))
        .previewLayout(.sizeThatFits)
    }
}
