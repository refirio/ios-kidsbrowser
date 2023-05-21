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
    @State private var counter = 0.0
    @State private var clear = false
    @State private var number1 = 0
    @State private var number2 = 0
    @State private var correct = 0
    @State private var answer = ""
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
            ZStack {
                Color.red.ignoresSafeArea()
                VStack {
                    if clear == true {
                        Text("使用時間を入力してください。")
                        HStack {
                            Slider(value: $counter, in: 1.0...60.0)
                            /*
                             TextField("", value: $counter, formatter: NumberFormatter())
                             .keyboardType(.numberPad)
                             //.textFieldStyle(.roundedBorder)
                             .background(.red.opacity(0.3))
                             .overlay(
                             RoundedRectangle(cornerRadius: 3)
                             .stroke(.white, lineWidth: 2)
                             )
                             .padding()
                             */
                            Text(String(Int(counter)) + "分")
                        }
                        Button("使用") {
                            print(counter)
                            stopping = false
                            clear = false
                            viewModel.setCount(Int(counter) * 60)
                            viewModel.startCounting()
                        }
                    } else {
                        Text("問題に回答してください。").onAppear {
                            counter = 3.0
                            number1 = Int.random(in: 0...10)
                            number2 = Int.random(in: 0...10)
                            correct = number1 + number2
                            answer = "?"
                        }
                        HStack {
                            Text(String(number1))
                            Text("+")
                            Text(String(number2))
                            Text("=")
                            Text(String(answer))
                            //Text(String(number1) + " + " + String(number2) + " = " + String(answer))
                            /*
                            Text("[ " + String(answer) + " ]")
                             */
                            /*
                            TextField("", text: $answer)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 3)
                                        .stroke(.white, lineWidth: 2)
                                )
                                .padding()
                             */
                            /*
                             TextField("", value: $answer, formatter: NumberFormatter())
                             .keyboardType(.numberPad)
                             .textFieldStyle(.roundedBorder)
                             .padding()
                             */
                            Button("×") {
                                if answer.count > 1 {
                                    answer.removeLast()
                                } else {
                                    answer = "?"
                                }
                            }
                        }
                        VStack {
                            HStack {
                                Button("1") {
                                    inputAnswer("1")
                                }
                                Button("2") {
                                    inputAnswer("2")
                                }
                                Button("3") {
                                    inputAnswer("3")
                                }
                            }
                            HStack {
                                Button("4") {
                                    inputAnswer("4")
                                }
                                Button("5") {
                                    inputAnswer("5")
                                }
                                Button("6") {
                                    inputAnswer("6")
                                }
                            }
                            HStack {
                                Button("7") {
                                    inputAnswer("7")
                                }
                                Button("8") {
                                    inputAnswer("8")
                                }
                                Button("9") {
                                    inputAnswer("9")
                                }
                            }
                            HStack {
                                Button("0") {
                                    inputAnswer("0")
                                }
                            }
                        }
                        Button("回答") {
                            if answer == String(correct) {
                                clear = true
                            }
                        }
                    }
                }.padding(50)
            }.foregroundColor(.white)
        }
    }

    func inputAnswer(_ value: String) -> Void {
        if answer == "?" {
            answer = ""
        }
        answer += value
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
