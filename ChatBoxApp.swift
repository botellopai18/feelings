
import SwiftUI


@main
struct ChatBoxApp: App {
    @StateObject var data = HistoryChat()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                NavigationLink("ChatView") {
                    ChatView()
                        .environmentObject(data)
                }
            }
            .environmentObject(data)
        }
    }
}
