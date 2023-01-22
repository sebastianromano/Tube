import SwiftUI

@main
struct Tube: App {
    let persistenceController = PersistenceController.shared
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            SwiftUIView()
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//                .frame(minWidth: 300, idealWidth: 300, maxWidth: .infinity, minHeight: 300, idealHeight: 300, maxHeight: .infinity)
        }.windowStyle(.hiddenTitleBar)
    }
}
