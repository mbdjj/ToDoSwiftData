//
//  ContentView.swift
//  ToDoSwiftData
//
//  Created by Marcin Bartminski on 28/07/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var context
    
    @State private var showCreateCategory = false
    @State private var showCreateToDo = false
    @State private var toDoToEdit: Item?
    
    @Query(sort: \.timestamp) private var items: [Item]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            if item.isCritical {
                                Image(systemName: "exclamationmark.3")
                                    .symbolVariant(.fill)
                                    .foregroundStyle(.red)
                                    .font(.largeTitle)
                                    .bold()
                            }
                            
                            Text(item.title)
                                .font(.largeTitle)
                                .bold()
                            
                            Text("\(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .shortened))")
                                .font(.callout)
                            
                            if let category = item.category {
                                Text(category.title)
                                    .foregroundStyle(.blue)
                                    .bold()
                                    .padding(.horizontal)
                                    .padding(.vertical, 8)
                                    .background(Color.blue.opacity(0.1), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                            }
                        }
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                item.isCompleted.toggle()
                            }
                        } label: {
                            Image(systemName: "checkmark")
                                .symbolVariant(.circle.fill)
                                .foregroundStyle(item.isCompleted ? .green : .gray)
                                .font(.largeTitle)
                        }
                        .buttonStyle(.plain)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            withAnimation {
                                context.delete(item)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                                .symbolVariant(.fill)
                        }
                        
                        Button {
                            toDoToEdit = item
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        .tint(.orange)
                    }
                }
            }
            .navigationTitle("My To Do List")
            .toolbar {
                ToolbarItem {
                    Button("New Category") {
                        showCreateCategory.toggle()
                    }
                }
            }
            .sheet(isPresented: $showCreateToDo, content: {
                NavigationStack {
                    ModifyToDoView()
                }
                .presentationDetents([.medium, .large])
            })
            .sheet(isPresented: $showCreateCategory, content: {
                NavigationStack {
                    CreateCategoryView()
                }
                .presentationDetents([.medium, .large])
            })
            .sheet(item: $toDoToEdit) {
                toDoToEdit = nil
            } content: { item in
                NavigationStack {
                    UpdateToDoView(item: item)
                }
            }
            .safeAreaInset(edge: .bottom, alignment: .leading) {
                Button {
                    showCreateToDo.toggle()
                } label: {
                    Label("New ToDo", systemImage: "plus")
                        .bold()
                        .font(.title2)
                        .padding(8)
                        .background(.gray.opacity(0.1), in: Capsule())
                        .padding(.leading)
                        .symbolVariant(.circle.fill)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
