//
//  ContentView.swift
//  Rust_iOS
//
//  Created by Aryan Rogye on 4/15/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var firstNum : String = ""
    @State var secondNum : String = ""
    @State private var result: Int32?
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                TextField("First Number", text: $firstNum)
                    .padding()
                    .background(Color(.white))
                    .foregroundStyle(.black)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .frame(width: 300, height: 50)
                    .padding(.bottom, 10)

                TextField("Second Number", text: $secondNum)
                    .padding()
                    .background(Color(.white))
                    .foregroundStyle(.black)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .frame(width: 300, height: 50)
                
                if let result = result {
                    Text("Result: \(result)")
                        .font(.headline)
                        .foregroundStyle(.black)
                }
                Spacer()
                Button("Add Numbers") {
                    if let a = Int(firstNum), let b = Int(secondNum) {
                        result = add_numbers(Int32(a), Int32(b)) // if Rust takes i32
                    } else {
                        result = nil // or show error
                    }
                }
                .padding()
                .frame(width: 300, height: 50)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(12)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
