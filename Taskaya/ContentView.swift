//
//  ContentView.swift
//  Taskaya
//
//  Created by 123 on 19/11/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    
    @Query(sort: \Task.title) private var tasks: [Task]
    @State var text: String = ""
    @State var selectedTask: TaskType? = .todo
//    @State var tasks: [Task] = [Task(title: "study swift"),Task(title: "practice swift")]
    var body: some View {
        ZStack{
            ScrollView{
                VStack{
                    HaveCircaleProgress(tasks: tasks)
                        .frame(height: 250)
                        .padding(.top, 70)
                    ForEach(tasks.indices, id: \.self){ index in
                        TaskRow(task: tasks[index])
                    }
                }
            }
            .safeAreaPadding(.bottom, 100)
            .scrollIndicators(.hidden)
            NewTaskView(text: $text, selectedTask: $selectedTask) { newTask in
                let newTask = Task(title: newTask.title, status: newTask.status)
                context.insert(newTask)
            }
            .frame(maxWidth: .infinity, alignment: .bottom)
        }
    }
}

//#Preview {
//    ContentView()
//}


