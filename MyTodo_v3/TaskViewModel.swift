//
//  TaskViewModel.swift
//  MyTodo_v3
//
//  Created by 荻野真浩 on 2021/10/08.
//

import Foundation
import Combine

class TaskViewModel: ObservableObject {
    @Published private(set) var tasks: [Task] = Array(Task.findAll())
    @Published var taskTitleField = ""
    @Published var taskTextField = ""
    @Published var deleteTask: Task?
    @Published var isDeleteAllTapped = false
    
    private var addTaskJob: AnyCancellable?
    private var deleteTaskJob: AnyCancellable?
    private var deleteAllTaskJob: AnyCancellable?
    init() {
        addTaskJob = self.$taskTextField
            .sink() { text in
                guard !text.isEmpty else {
                    return
                }
                let task = Task()
                task.text = text
                self.tasks.append(task)
                Task.add(task)
            }
        deleteTaskJob = self.$deleteTask
            .sink() { task in
                guard let task = task else {
                    return
                }
                if let index = self.tasks.firstIndex(of: task) {
                    self.tasks.remove(at: index)
                    Task.delete(task)
                }
            }
        deleteAllTaskJob = self.$isDeleteAllTapped
            .sink() { isDeleteAllTapped in
                if (isDeleteAllTapped) {
                    Task.delete(self.tasks)
                    self.tasks.removeAll()
                    self.isDeleteAllTapped = false
                }
            }
    }
}
