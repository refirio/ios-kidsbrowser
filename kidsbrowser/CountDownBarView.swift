//
//  CountDownBarView.swift
//  kidsbrowser
//
//  Created by refirio.
//

import SwiftUI

struct CountDownBarView: View {
    // カウントダウン状況
    var countDownProgress: Double

    var body: some View {
        VStack {
            GeometryReader { geometry in
                Rectangle()
                    .foregroundColor(Color.gray)
                    .opacity(0.3)
                    .frame(width: geometry.size.width)
                Rectangle()
                    .foregroundColor(Color.red)
                    .frame(width: geometry.size.width * CGFloat(countDownProgress))
            }
        }.frame(height: 2.0)
    }
}
