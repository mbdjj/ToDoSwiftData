//
//  CreateCategoryView.swift
//  ToDoSwiftData
//
//  Created by Marcin Bartminski on 01/08/2023.
//

import SwiftUI
import SwiftData

@Model class Category {
    @Attribute(.unique) var title: String
    var items: [Item]?
    
    init(title: String = "") {
        self.title = title
    }
}

struct CreateCategoryView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var title = ""
    
    @Query private var categories: [Category]
    
    var body: some View {
        List {
            Section("Category Title") {
                TextField("Enter title here", text: $title)
                Button("Add category") {
                    withAnimation {
                        let category = Category(title: title)
                        modelContext.insert(category)
                        category.items = []
                        title = ""
                    }
                }
                .disabled(title.isEmpty)
            }
            
            Section("Categories") {
                if categories.isEmpty {
                    ContentUnavailableView("No Categories", systemImage: "archivebox")
                } else {
                    ForEach(categories) { category in
                        Text(category.title)
                            .swipeActions {
                                Button {
                                    withAnimation {
                                        modelContext.delete(category)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash.fill")
                                }
                            }
                    }
                }
            }
        }
        .navigationTitle("Add Category")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Dismiss") {
                    dismiss.callAsFunction()
                }
            }
        }
    }
}

#Preview {
    CreateCategoryView()
}
