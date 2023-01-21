import SwiftUI

@available(OSX 11.0, *)
struct ContentView: View {
    private var url: URL? = URL(string: "https://invidious.snopyta.org/search/")
    var body: some View {
        WebView(data: WebViewData(url: self.url!))
            .frame(minWidth: 640, idealWidth: 640, maxWidth: .infinity, minHeight: 400, idealHeight: 400, maxHeight: .infinity)
  }
}
