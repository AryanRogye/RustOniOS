//
//  ContentView.swift
//  Rust_iOS
//
//  Created by Aryan Rogye on 4/15/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let result = add_numbers(10, 10)
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Text("\(result)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
