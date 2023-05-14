//
//  WebProgressBarView.swift
//  kidsbrowser
//
//  Created by refirio.
//

import SwiftUI

struct WebProgressBarView: View {
    // 読み込みの進捗状況
    var loadingProgress: Double

    var body: some View {
        VStack {
            GeometryReader { geometry in
                Rectangle()
                    .foregroundColor(Color.gray)
                    .opacity(0.3)
                    .frame(width: geometry.size.width)
                Rectangle()
                    .foregroundColor(Color.blue)
                    .frame(width: geometry.size.width * CGFloat(loadingProgress))
            }
        }.frame(height: 2.0)
    }
}
