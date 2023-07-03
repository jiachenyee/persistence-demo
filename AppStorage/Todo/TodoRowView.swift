//
//  TodoRowView.swift
//  Todo
//
//  Created by Jia Chen Yee on 03/07/23.
//

import SwiftUI

struct TodoRowView: View {
    
    var isPresented: Bool
    
    @Binding var isCompleted: Bool
    @Binding var title: String
    
    var body: some View {
        Group {
            if isPresented {
                HStack {
                    Button {
                        isCompleted.toggle()
                    } label: {
                        Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                    }
                    TextField("Title", text: $title)
                }
                .onChange(of: title) { newValue in
                    if title.isEmpty {
                        isCompleted = false
                    }
                }
            }
        }
    }
}

struct TodoRowView_Previews: PreviewProvider {
    static var previews: some View {
        TodoRowView(isPresented: true,
                    isCompleted: .constant(true),
                    title: .constant("Water plants"))
        .previewLayout(.sizeThatFits)
    }
}
