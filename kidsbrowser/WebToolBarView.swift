//
//  WebToolBarView.swift
//  kidsbrowser
//
//  Created by refirio.
//

import SwiftUI

struct WebToolBarView: View {
    // アクション
    @Binding var action: WebContentView.Action
    // 戻れるか
    var canGoBack: Bool
    // 進めるか
    var canGoForward: Bool

    var body: some View {
        VStack() {
            Divider()

            HStack(spacing: 16) {
                Button(action: {
                    action = .goBack
                }) {
                    Image(systemName: "arrow.backward")
                }.disabled(!canGoBack)

                Button(action: {
                    action = .goForward
                }) {
                    Image(systemName: "arrow.forward")
                }.disabled(!canGoForward)

                Spacer()

                Button(action: {
                    action = .reload
                }) {
                    Image(systemName: "arrow.clockwise")
                }
            }
            .padding(.top, 8)
            .padding(.horizontal, 16)

            Spacer()
        }.frame(height: 60)
    }
}
