//
//  NewTaskView.swift
//  Taskaya
//
//  Created by 123 on 26/11/2024.
//

import SwiftUI

struct NewTaskView: View {
    @Binding var text: String
    @State var show = false
    @State var show2 = false
    @Namespace var animation
    @FocusState var isTyping
    @Binding var selectedTask: TaskType?
    
    var onSave: (Task) -> Void
    
    var body: some View {
        VStack{
            ZStack(alignment: show ? .topLeading : .center){
                RoundedRectangle(cornerRadius: show ? 25 : 40)
                    .foregroundStyle(Color(.systemGray6))
                VStack(){
                    if !show{
                        Text("New Task").bold()
                            .matchedGeometryEffect(id: "text", in: animation)
                            .offset(y: 10)
                            .padding()
                    }
                    else{
                        VStack{
                            ZStack(alignment: .topLeading){
                                TextEditor(text: $text)
                                    .focused($isTyping)
                                    .scrollContentBackground(.hidden)
                                    .frame(height: 100)
                                if !isTyping{
                                    Text("\(Image(systemName: "pencil")) type here")
                                        .fixedSize(
                                            horizontal: true,
                                            vertical: true
                                        )
                                        .foregroundStyle(.gray)
                                        .matchedGeometryEffect(id: "text", in: animation)
                                }
                            }
                            .padding()
                        }
                    }
                    Spacer()
                    
                    TaskTypeView(selectedTask: selectedTask)
                        .padding()
                        .frame(height: show ? 50 : 0)
                        .opacity(show2 ? 1 : 0)
                        .padding(.bottom, 10)
                    
                }
            }
            .frame(height: show ? 200 : 60)
            .clipped()
            .overlay(alignment : .topTrailing){
                if show2 {
                    Image(systemName: "xmark")
                        .padding(10)
                        .background(Color(.systemGray4), in: Circle())
                        .padding(10)
                        .onTapGesture {
                            close()
                        }
                }
                
            }
            .onTapGesture {
                if !show{
                    open()
                }
            }
            Button(action: {
                if let selectedTask = selectedTask{
                    let newTask = Task(title: text, status: selectedTask)
                    onSave(newTask)
                    close()
                }
            }, label: {
                Text("Save")
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .clipShape(Capsule())
                    .padding(.vertical)
                    .opacity(show ? 1 : 0)
            })
            .tint(.primary)
            .disabled(text.isEmpty)
        }
        
        
        .frame(maxHeight: .infinity, alignment: .bottom)
        .offset(y: show ? 0 : 100)
    }
    func open(){
        withAnimation(.spring){
            show.toggle()
        }
        withAnimation(.spring (duration: show ? 0.5 : 0.3).delay(show ? 0.5 : 0)){
            show2.toggle()
        }
    }
    func close(){
        text = ""
        isTyping = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01){
            open()
        }
    }
}

#Preview {
    NewTaskView(text: .constant(""), selectedTask: .constant(.done), onSave: {_ in})
}
