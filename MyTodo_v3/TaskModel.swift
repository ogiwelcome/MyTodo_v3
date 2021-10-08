//
//  TodoModel.swift
//  MyTodo_v3
//
//  Created by 荻野真浩 on 2021/10/06.
//

import Foundation
import RealmSwift

class Task: Object, Identifiable {
    @objc dynamic var title = ""
    @objc dynamic var text = ""
    @objc dynamic var date = Date()
}

extension Task {
    private static var config = Realm.Configuration(schemaVersion: 1)
    private static var realm = try! Realm(configuration: config)
    
    static func findAll() -> Results<Task> {
        realm.objects(self)
    }
    static func add(_ task: Task) {
        try! realm.write {
            realm.add(task)
        }
    }
    static func delete(_ task: Task) {
        try! realm.write {
            realm.delete(task)
        }
    }
    static func delete(_ tasks: [Task]) {
        try! realm.write {
            realm.delete(tasks)
        }
    }
}
