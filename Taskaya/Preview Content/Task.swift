
import SwiftUI
import SwiftData


@Model
class Task: Identifiable{ 
    var id = UUID()
    var title: String
    var status: TaskType
    
    init(id: UUID = UUID(), title: String, status: TaskType = .todo) {
        self.id = id
        self.title = title
        self.status = status
    }
}


struct TaskTypeView: View {
    @State var selectedTask: TaskType? 
    var body: some View {
        VStack {
            HStack{
                TaskTypeButton(
                    title: "Todo",
                    task: .todo,
                    selectedTask: $selectedTask
                )
                Spacer()
                TaskTypeButton(
                    title: "In Progress",
                    task: .inProgress,
                    selectedTask: $selectedTask
                )
                Spacer()
                TaskTypeButton(
                    title: "Done",
                    task: .done,
                    selectedTask: $selectedTask
                )
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .background(
                Capsule()
                    .foregroundStyle(.gray.opacity(0.3))
                    .frame(width: selectedTask?.capsuleWidth, height: 50)
                    .alignmentGuide(.leading){_ in 0}
                    .frame(
                        maxWidth: .infinity,
                        alignment: selectedTask?.alignment ?? .center
                    )
                    .animation(.easeOut(duration: 0.3), value: selectedTask)
            )
        }
    }
}

enum TaskType: CaseIterable, Codable{
    case todo
    case inProgress
    case done
    var alignment: Alignment{
        switch self {
        case .todo:
            return .leading
        case .inProgress:
            return  .center
        case .done:
            return  .trailing
        }
    }
    var capsuleWidth: CGFloat{
        switch self {
        case .todo,.done:
            return 80
        case .inProgress:
            return 120
        
        }
    }
}

struct TaskTypeButton: View {
    var title: String
    var task: TaskType
    @Binding var selectedTask: TaskType?
    var body: some View {
        Text(title).bold()
            .foregroundStyle(selectedTask == task  ? Color.primary  : .gray)
            .onTapGesture {
                selectedTask = task
            }
    }
}

#Preview {
    TaskTypeView(selectedTask: .done )
}
