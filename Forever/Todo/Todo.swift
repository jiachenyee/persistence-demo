//
//  Todo.swift
//  Todo
//
//  Created by Jia Chen Yee on 03/07/23.
//

import Foundation

struct Todo: Codable, Identifiable, Equatable {
    var id = UUID()
    
    var title: String
    var isCompleted: Bool
}
