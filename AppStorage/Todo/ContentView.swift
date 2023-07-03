//
//  ContentView.swift
//  Todo
//
//  Created by Jia Chen Yee on 03/07/23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("title1") var title1: String = ""
    @AppStorage("isCompleted1") var isCompleted1: Bool = false
    
    @AppStorage("title2") var title2: String = ""
    @AppStorage("isCompleted2") var isCompleted2: Bool = false
    
    @AppStorage("title3") var title3: String = ""
    @AppStorage("isCompleted3") var isCompleted3: Bool = false
    
    @AppStorage("title4") var title4: String = ""
    @AppStorage("isCompleted4") var isCompleted4: Bool = false
    
    @AppStorage("title5") var title5: String = ""
    @AppStorage("isCompleted5") var isCompleted5: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                TodoRowView(isPresented: true,
                            isCompleted: $isCompleted1,
                            title: $title1)
                TodoRowView(isPresented: !title1.isEmpty,
                            isCompleted: $isCompleted2,
                            title: $title2)
                TodoRowView(isPresented: !title2.isEmpty,
                            isCompleted: $isCompleted3,
                            title: $title3)
                TodoRowView(isPresented: !title3.isEmpty,
                            isCompleted: $isCompleted4,
                            title: $title4)
                TodoRowView(isPresented: !title4.isEmpty,
                            isCompleted: $isCompleted5,
                            title: $title5)
            }
            .navigationTitle("Todos")
            .onAppear {
                print("You can find the data here: \(NSHomeDirectory())/Library/Preferences/\(Bundle.main.bundleIdentifier!).plist")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
