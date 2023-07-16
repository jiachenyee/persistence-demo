//
//  OnboardingView.swift
//  Todo
//
//  Created by Jia Chen Yee on 16/07/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @AppStorage("username") private var username = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $username)
                } header: {
                    Text("Name")
                }
                
                Button("Done") {
                    dismiss()
                }
                .disabled(username.isEmpty)
            }
            .navigationTitle("Welcome")
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
