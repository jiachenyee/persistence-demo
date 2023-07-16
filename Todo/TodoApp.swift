//
//  TodoApp.swift
//  Todo
//
//  Created by Jia Chen Yee on 03/07/23.
//

import SwiftUI

@main
struct TodoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
