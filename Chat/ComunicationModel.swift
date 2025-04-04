import SwiftUI
import Foundation
import GoogleGenerativeAI


class ComunicationModel : ObservableObject{
    let model: GenerativeModel
    var response : String?
    init() {
        guard let value = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            fatalError("Error: Key no encontrada")
        }
        self.model = GenerativeModel(name: "gemini-1.5-flash-latest", apiKey: value)
        self.response = nil
    }
    
    
    func generateAnswer(question: String) async throws {
        self.response = nil
        do {
           let response = try await model.generateContent(question)
            self.response = response.text ?? "Bad request try again"
        } catch {
            throw error
        }
    }
    
    func describeEmotion(question: String) async throws {
        self.response = nil
        do {
           let response = try await model.generateContent(
                "Necesito que respondas este prompt con la emocion descrita a continuacion en a lo mas 3 palabras. Emocion: \(question)"
           )
            self.response = response.text ?? "Bad request try again"
        } catch {
            throw error
        }
    }
    
    func testChat(question: String, historyData: HistoryChat) async throws {
        self.response = nil
        // Optionally specify existing chat history
        //let history = [
        //    ModelContent(role: "user", parts: "Hello, I have 2 dogs in my house."),
        //    ModelContent(role: "model", parts: "Great to meet you. What would you like to know?"),
        //]
        let history: [ModelContent] = historyData.history.map { mensaje in
            ModelContent(
                role: mensaje.user,
                parts: mensaje.content  // Direct mapping from content to parts
            )
        }

        // Initialize the chat with optional chat history
        let chat = model.startChat(history: history)

        // To generate text output, call sendMessage and pass in the message
        let response = try await chat.sendMessage(question)
        self.response = response.text ?? "Bad request try again"
        // [END chat]
    }

}
