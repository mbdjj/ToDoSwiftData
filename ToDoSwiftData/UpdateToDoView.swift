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
    
    @Bindable var item: ToDoItem
    
    var body: some View {
        List {
            TextField("Name", text: $item.title)
            DatePicker("Choose a date", selection: $item.timestamp)
            Toggle("Important?", isOn: $item.isCritical)
            Button("Update") {
                dismiss.callAsFunction()
            }
        }
        .navigationTitle("Update ToDo")
    }
}

#Preview {
    UpdateToDoView(item: ToDoItem())
}
