//
//  TaskRow.swift
//  Taskaya
//
//  Created by 123 on 19/11/2024.
//

import SwiftUI

struct TaskRow: View {
     var task: Task
    @State private var tapCount = 0
    @State private var tapTimer: Timer?
    var body: some View {
        HStack{
            Text(task.title)
                .padding()
            Spacer()
            Image(systemName: iconForStatus(task.status))
                .frame(width: 20, height: 20 )
                .contentTransition(.symbolEffect)
            
        }
        .padding()
        .background(Color(.systemGray5))
        .cornerRadius(10)
        .overlay(alignment: .leading){
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 10)
                .foregroundStyle(colorForStatus(task.status))
        }
        .clipShape(.rect(cornerRadius: 20))
        .contentShape(Rectangle())
        .onTapGesture {
            tapCount += 1
            tapTimer?.invalidate()
            tapTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false){_ in
                print(tapCount)
                if tapCount == 1{
                    withAnimation{
                        cycleStatus()
                    }
                }
                else if tapCount == 2{
                    withAnimation{
                        task.status = .done
                    }
                }else{
                    tapCount = 0
                }
                
            }
        }
    }
    private func colorForStatus(_ status: TaskType) -> Color {
        switch status {
        case .todo: return .gray.opacity(0.4)
        case .inProgress: return .yellow
        case .done: return .accentColor
        }
    }
    private func iconForStatus(_ status: TaskType) -> String {
        switch status {
        case .todo:
            return "zzz"
        case .inProgress:
            return "hourglass"
        case .done:
            return "checkmark"
        }
    }
    private func cycleStatus() {
        switch task.status {
        case .todo: task.status = .inProgress
        case .inProgress: task.status = .todo
        case .done: task.status = .todo
        }
    }
}

#Preview {
    ContentView()
}
