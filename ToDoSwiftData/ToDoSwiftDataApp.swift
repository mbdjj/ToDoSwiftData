//
//  ToDoSwiftDataApp.swift
//  ToDoSwiftData
//
//  Created by Marcin Bartminski on 28/07/2023.
//

import SwiftUI
import SwiftData

@main
struct ToDoSwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Item.self)
        }
    }
}
