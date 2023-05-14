//
//  ContentView.swift
//  kidsbrowser
//
//  Created by refirio.
//

import SwiftUI

struct ContentView: View {
    let url = URL(string: "https://www.youtube.com/feed/library")!
    @State private var stopping = true
    @State private var counter = 0
    @State private var clear = false
    @State private var number1 = 0
    @State private var number2 = 0
    @State private var correct = 0
    @State private var answer = 0
    @ObservedObject private var viewModel = TimerModel()
    var body: some View {
        VStack {
            if viewModel.count > 0 {
                VStack {
                    CountDownBarView(countDownProgress: Double(viewModel.count) / Double(counter * 60))
                }.frame(height: 2.0)

                WebView(url: url)
            } else {
                Text("Stopping...").onAppear {
                    stopping = true
                }
            }
        }
        .fullScreenCover(isPresented: $stopping) {
            VStack {
                if clear == true {
                    Text("使用時間を入力してください。")
                    TextField("", value: $counter, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    Text("分")
                    Button("使用") {
                        stopping = false
                        clear = false
                        viewModel.setCount(counter * 60)
                        viewModel.startCounting()
                    }
                } else {
                    Text("問題に回答してください。").onAppear {
                        counter = 3
                        number1 = Int.random(in: 0...10)
                        number2 = Int.random(in: 0...10)
                        correct = number1 + number2
                        answer = 0
                    }
                    Text(String(number1) + " + " + String(number2) + " =")
                    TextField("", value: $answer, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    Button("回答") {
                        if answer == correct {
                            clear = true
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
