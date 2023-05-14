//
//  ContentView.swift
//  kidsbrowser
//
//  Created by refirio.
//

import SwiftUI

struct ContentView: View {
    let url = URL(string: "https://www.youtube.com/feed/library")!
    var body: some View {
        WebView(url: url)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
