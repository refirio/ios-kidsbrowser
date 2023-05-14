//
//  WebContentView.swift
//  kidsbrowser
//
//  Created by refirio.
//

import SwiftUI
import WebKit

struct WebContentView: UIViewRepresentable {
    // 表示するURL
    let url: URL
    // アクション
    @Binding var action: Action
    // 戻れるか
    @Binding var canGoBack: Bool
    // 進めるか
    @Binding var canGoForward: Bool
    // ローディング中か
    @Binding var isLoading: Bool
    // 読み込みの進捗状況
    @Binding var loadingProgress: Double
    // ページタイトル
    @Binding var pageTitle: String
    // WebViewのアクション
    enum Action {
        case none
        case goBack
        case goForward
        case reload
    }

    // 表示するView
    private let webView = WKWebView()

    func makeUIView(context: Context) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        switch action {
        case .goBack:
            uiView.goBack()
        case .goForward:
            uiView.goForward()
        case .reload:
            uiView.reload()
        case .none:
            break
        }
        action = .none
    }

    func makeCoordinator() -> WebContentView.Coordinator {
        return Coordinator(parent: self)
    }

    static func dismantleUIView(_ uiView: WKWebView, coordinator: Coordinator) {
        coordinator.observations.forEach({ $0.invalidate() })
        coordinator.observations.removeAll()
    }
}

extension WebContentView {
    final class Coordinator: NSObject, WKNavigationDelegate {
        let parent: WebContentView
        var observations: [NSKeyValueObservation] = []

        init(parent: WebContentView) {
            self.parent = parent

            let progressObservation = parent.webView.observe(\.estimatedProgress, options: .new, changeHandler: { _, value in
                parent.loadingProgress = value.newValue ?? 0
            })
            let isLoadingObservation = parent.webView.observe(\.isLoading, options: .new, changeHandler: { _, value in
                parent.isLoading = value.newValue ?? false
            })
            observations = [
                progressObservation,
                isLoadingObservation
            ]
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.canGoBack = webView.canGoBack
            parent.canGoForward = webView.canGoForward
            parent.pageTitle = webView.title ?? ""
        }
    }
}
