import Foundation
import SwiftUI
import WebKit
import Combine
import AppKit
import SceneKit

class WebViewData: ObservableObject {
  @Published var loading = false
  @Published var url: URL?

  init(url: URL) {
    self.url = url
  }
}

@available(OSX 11.0, *)
struct WebView: NSViewRepresentable {
  @ObservedObject var data: WebViewData

  func makeNSView(context: Context) -> WKWebView {
    return context.coordinator.webView
  }

  func updateNSView(_ nsView: WKWebView, context: Context) {
    guard context.coordinator.loadedUrl != data.url else { return }
    context.coordinator.loadedUrl = data.url

    guard let url = data.url else { return }
    let request = URLRequest(url: url)
    nsView.load(request)
  }

  func makeCoordinator() -> WebViewCoordinator {
    return WebViewCoordinator(data: data)
  }
}

@available(OSX 11.0, *)
class WebViewCoordinator: NSObject, WKNavigationDelegate {
  @ObservedObject var data: WebViewData

  lazy var webView = WKWebView()
  var loadedUrl: URL?

  init(data: WebViewData) {
      self.data = data
      super.init()
      self.webView.navigationDelegate = self
      self.webView.allowsBackForwardNavigationGestures = true
      self.webView.allowsLinkPreview = true
      self.webView.allowsMagnification = true
  }

  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    data.loading = false
  }

  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    data.loading = true
  }

  func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    handleError(error, title: "Navigation Error")
    data.loading = false
  }

  func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
    handleError(error, title: "Loading Error")
    data.loading = false
  }

  func handleError(_ error: Error, title: String) {
    #if os(macOS)
    let alert = NSAlert()
    alert.messageText = title
    alert.informativeText = error.localizedDescription
    alert.alertStyle = .warning
    alert.runModal()
    #else
    print("\(title): \(error.localizedDescription)")
    #endif
  }
}
