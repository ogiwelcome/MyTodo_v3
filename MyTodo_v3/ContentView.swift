//
//  ContentView.swift
//  MyTodo_v3
//
//  Created by 荻野真浩 on 2021/10/02.
//
// 参考実装入れてます
// https://tech-blog.rakus.co.jp/entry/20210331/swift

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
