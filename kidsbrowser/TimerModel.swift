//
//  TimerModel.swift
//  kidsbrowser
//
//  Created by refirio.
//

import Foundation
import Combine

class TimerModel: ObservableObject {
    @Published var count = 0
    @Published var isTimerRunning = false

    private var cancellable: AnyCancellable?

    func startCounting() {
        isTimerRunning = true
        cancellable = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if self.count <= 0 {
                    self.stopCounting()
                } else {
                    self.count -= 1
                }
            }
    }

    func stopCounting() {
        isTimerRunning = false
        cancellable?.cancel()
    }

    func setCount(_ newCount: Int) {
        count = newCount
    }
}

