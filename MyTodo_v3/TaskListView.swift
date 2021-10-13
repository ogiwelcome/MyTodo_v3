//
//  TaskView.swift
//  MyTodo_v3
//
//  Created by 荻野真浩 on 2021/10/08.
//

import Foundation
import SwiftUI
import RealmSwift

struct TaskListView: View {
    @ObservedObject var viewModel = TaskViewModel()
    @State private var isTaskTextFieldPresented = false
    @State private var isDeleteAlertPresented = false
    @State private var isDeleteAllAlertPresented = false
    @State private var taskTextField = ""
    
    var body: some View {
        NavigationView {
            VStack {
                if (isTaskTextFieldPresented) {
                    TextField("タスクを入力してください", text: $taskTextField)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .keyboardType(.asciiCapable)
                }
                List {
                    ForEach(viewModel.tasks.sorted {
                        $0.postedDate > $1.postedDate
                    }) {task in
                        HStack {
                            TaskRowView(task: task)
                            Spacer()
                            Text("削除").onTapGesture {
                                isDeleteAlertPresented.toggle()
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.red)
                        }
                        .alert(isPresented: $isDeleteAlertPresented) {
                            Alert(title: Text("警告"),
                                  message: Text("タスクを削除します。\nよろしいですか？"),
                                  primaryButton: .cancel(Text("いいえ")),
                                  secondaryButton: .destructive(Text("はい")){
                                    viewModel.deleteTask = task
                                  }
                            )
                        }//alert
                    }//forEach
                }//list
            }//VStack
            .navigationTitle("タスク一覧")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("全削除") {
                        isDeleteAllAlertPresented.toggle()
                    }
                    .disabled(viewModel.tasks.isEmpty)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("追加") {
                        if (isTaskTextFieldPresented) {
                            viewModel.taskTextField = taskTextField
                            taskTextField = ""
                        }
                        isTaskTextFieldPresented.toggle()
                    }.disabled(isTaskTextFieldPresented && taskTextField.isEmpty)
                }
            }.alert(isPresented: $isDeleteAllAlertPresented) {
                Alert(title: Text("警告"),
                      message: Text("全てのタスクを削除します。\nよろしいですか？"),
                      primaryButton: .cancel(Text("いいえ")),
                      secondaryButton: .destructive(Text("はい")) {
                        viewModel.isDeleteAllTapped = true
                      }
                )
            }
        }
    }
}

struct TaskRowView: View {
    var task: Task
    var body: some View {
        VStack(alignment: .leading) {
            Text(formatDate(task.postedDate))
                .font(.caption)
                .fontWeight(.bold)
            Text(task.text)
                .font(.body)
        }
    }
    func formatDate(_ date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.string(from: date)
    }
}
