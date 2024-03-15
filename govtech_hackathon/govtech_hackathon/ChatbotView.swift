import SwiftUI
import SwiftOpenAI

struct ChatbotView: View {
    @State private var messageText: String = ""
    @State private var messageList: [String] = []
    var openAI = SwiftOpenAI(apiKey: "your-api-key")
    
    // Define the initial message to send to the chatbot. This message is the key to guide the user correctly.
    private let initialMessage = "I would like you to be a very friendly assistant who summarizes the key characteristics of a person in a short paragraph. To do this, I want you to ask ten personalized questions that cover personal interests, skills, expertise and work position. I want you to reveal the short paragraph after asking the tenth question. I want you to only ask one question at a time. If you understood my instructions, write in a short answer that its nice to talk to me and start with the first question. After every answer I give, you should ask the next question."
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(messageList, id: \.self) { message in
                        HStack {
                            if message.starts(with: "You:") {
                                Spacer()
                            }
                            Text(message)
                                .padding()
                                .background(message.starts(with: "You:") ? Color.red : Color.red.opacity(0.4))
                                .cornerRadius(30)
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, alignment: message.starts(with: "You:") ? .trailing : .leading)
                            if message.starts(with: "Bot:") {
                                Spacer()
                            }
                        }
                    }
                }
            }
            .padding(.top)
            
            Spacer()
            
            HStack {
                TextField("Type a message...", text: $messageText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                    .padding(.leading)
                
                Button(action: sendMessage) {
                    Image(systemName: "paperplane.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44)
                        .foregroundColor(.red)
                }
                .padding(.trailing)
            }
            .padding(.bottom, 10)
        }
        .onAppear(perform: sendInitialMessage)
    }
    
    private func sendMessage() {
        guard !messageText.isEmpty else { return }
        let userInput = messageText
        messageList.append("You: \(userInput)")
        messageText = ""
        sendToChatbot(message: userInput)
    }
    
    private func sendInitialMessage() {
        // Send the initial message to the chatbot as if it were from the user, but don't display it
        sendToChatbot(message: initialMessage)
    }
    
    private func sendToChatbot(message: String) {
        Task {
            do {
                let result = try await openAI.createChatCompletions(model: .gpt3_5(.turbo),
                                                                    messages: [.init(text: message, role: .user)])
                if let response = result, let firstChoice = response.choices.first {
                    let botResponse = firstChoice.message.content
                    DispatchQueue.main.async {
                        // Append only the bot's response to the message list
                        messageList.append("Bot: \(botResponse)")
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}

struct ChatbotView_Previews: PreviewProvider {
    static var previews: some View {
        ChatbotView()
    }
}
