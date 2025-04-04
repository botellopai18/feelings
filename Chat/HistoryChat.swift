
import SwiftUI


class HistoryChat : ObservableObject {
    @Published var history = [
        Mensaje(
            user:  "model",
            content: "¡Hola! soy Fily, estoy aqui para escuchar tus emociones. ¿Cómo te sientes hoy?"
        ),
        Mensaje(
            user:  "user",
            content: "Tengo 367 perros, recuerdalo"
        ),
    ]
}

struct Mensaje : Identifiable {
    var user: String
    var content: String
    
    var id = UUID()
}
