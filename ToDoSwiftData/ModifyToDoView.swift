//
//  CreateToDoView.swift
//  ToDoSwiftData
//
//  Created by Marcin Bartminski on 28/07/2023.
//

import SwiftUI
import SwiftData

struct ModifyToDoView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    @State private var item = Item()
    @State private var selectedCategory: Category?
    
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
                Button("Create") {
                    save()
                    dismiss.callAsFunction()
                }
            }
            
        }
        .navigationTitle("Create ToDo")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Dismiss") {
                    dismiss.callAsFunction()
                }
            }
            
            ToolbarItem(placement: .primaryAction) {
                Button("Done") {
                    save()
                    dismiss.callAsFunction()
                }
                .bold()
            }
        }
    }
}

private extension ModifyToDoView {
    func save() {
        context.insert(item)
        item.category = selectedCategory
        selectedCategory?.items?.append(item)
    }
}

#Preview {
    ModifyToDoView()
        .modelContainer(for: Item.self)
}
