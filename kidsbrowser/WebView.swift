//
//  WebView.swift
//  kidsbrowser
//
//  Created by refirio.
//

import SwiftUI

struct WebView: View {
    // 表示するURL
    let url: URL

    // アクション
    @State private var action: WebContentView.Action = .none
    // 戻れるか
    @State private var canGoBack: Bool = false
    // 進めるか
    @State private var canGoForward: Bool = false
    // ローディング中か
    @State private var isLoading: Bool = false
    // 読み込みの進捗状況
    @State private var loadingProgress: Double = 0.0
    // ページタイトル
    @State private var pageTitle: String = "Now Loading..."
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if isLoading {
                    WebProgressBarView(loadingProgress: loadingProgress)
                }

                WebContentView(
                    url: url,
                    action: $action,
                    canGoBack: $canGoBack,
                    canGoForward: $canGoForward,
                    isLoading: $isLoading,
                    loadingProgress: $loadingProgress,
                    pageTitle: $pageTitle
                ).navigationBarTitle(Text(pageTitle), displayMode: .inline)

                WebToolBarView(
                    action: $action,
                    canGoBack: canGoBack,
                    canGoForward: canGoForward
                )
            }
        }
        // iPadでも画面全体に表示する
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
