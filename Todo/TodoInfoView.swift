//
//  TodoInfoView.swift
//  Todo
//
//  Created by Jia Chen Yee on 16/07/23.
//

import SwiftUI
import PhotosUI

struct TodoInfoView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var todo: Todo
    
    @State private var isPhotosPickerPresented = false
    @State private var photosPickerItem: PhotosPickerItem?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if let imageURL = todo.imageURL {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .ignoresSafeArea()
                    } placeholder: {
                        EmptyView()
                    }
                }
                
                Form {
                    Section("Title") {
                        TextField("Name", text: Binding(get: {
                            todo.title ?? ""
                        }, set: { value in
                            todo.title = value
                            
                            do {
                                try viewContext.save()
                            } catch {
                                print("Failed to save: \(error.localizedDescription)")
                            }
                        }))
                    }
                    
                    Button {
                        isPhotosPickerPresented = true
                    } label: {
                        Label(todo.imageURL == nil ? "Add Image" : "Change Image",
                              systemImage: "photo.on.rectangle.angled")
                    }
                    
                    Button {
                        todo.isCompleted.toggle()
                        try! viewContext.save()
                    } label: {
                        if todo.isCompleted {
                            Label("Mark as Undone", systemImage: "circle")
                        } else {
                            Label("Mark as Done", systemImage: "checkmark.circle.fill")
                        }
                    }
                }
            }
        }
        .photosPicker(isPresented: $isPhotosPickerPresented, selection: $photosPickerItem)
        .onChange(of: photosPickerItem) { photosPickerItem in
            if let photosPickerItem {
                photosPickerItem.loadTransferable(type: Data.self) { result in
                    switch result {
                    case .success(let imageData):
                        saveImage(data: imageData)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func saveImage(data: Data?) {
        guard let data else { return }
        do {
            let storageURL = URL.documentsDirectory.appending(component: UUID().uuidString)
            print(storageURL)
            
            try data.write(to: storageURL)
            
            todo.imageURL = storageURL
            
            Task {
                try await MainActor.run {
                    try viewContext.save()
                }
            }
        } catch {
            print("Failed to save image:", error.localizedDescription)
        }
    }
}
