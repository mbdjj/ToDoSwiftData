//
//  UpdateToDoView.swift
//  ToDoSwiftData
//
//  Created by Marcin Bartminski on 30/07/2023.
//

import SwiftUI
import SwiftData

struct UpdateToDoView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var selectedCategory: Category?
    @Bindable var item: Item
    
    @Query private var categories: [Category]
    
    var body: some View {
        List {
            Section("ToDo Title") {
                TextField("Name", text: $item.title)
            }
            
            Section("General") {
                DatePicker("Choose a date", selection: $item.timestamp)
                Toggle("Important?", isOn: $item.isCritical)
            }
            
            Section("Select A Category") {
                Picker("", selection: $selectedCategory) {
                    Text("None")
                        .tag(nil as Category?)
                    
                    ForEach(categories) { category in
                        Text(category.title)
                            .tag(category as Category?)
                    }
                }
                .labelsHidden()
                .pickerStyle(.inline)
            }
            
            Section {
                Button("Update") {
                    item.category = selectedCategory
                    dismiss.callAsFunction()
                }
            }
        }
        .navigationTitle("Update ToDo")
        .onAppear {
            selectedCategory = item.category
        }
    }
}

#Preview {
    UpdateToDoView(item: Item())
}
