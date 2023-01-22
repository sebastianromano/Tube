//
//  SwiftUIView.swift
//  Tube
//
//  Created by Sebastian Romano on 2023-01-22.
//

import SwiftUI

struct SwiftUIView: View {
        private var url: URL? = URL(string: "https://invidious.snopyta.org/search/")
        var body: some View {
            WebView(data: WebViewData(url: self.url!))
                .frame(minWidth: 640, idealWidth: 640, maxWidth: .infinity, minHeight: 400, idealHeight: 400, maxHeight: .infinity)
      }
    }

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
