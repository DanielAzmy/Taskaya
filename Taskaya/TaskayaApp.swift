//
//  TaskayaApp.swift
//  Taskaya
//
//  Created by 123 on 19/11/2024.
//

import SwiftUI
import SwiftData


@main
struct TaskayaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: Task.self)
    }
}
