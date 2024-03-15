import SwiftUI
import SwiftOpenAI

struct ChatbotView: View {
    @State private var messageText: String = ""
    @State private var messageList: [String] = []
    var openAI = SwiftOpenAI(apiKey: "your-api-key")
    
    // Define the initial message to send to the chatbot. This message is the key to guide the user correctly.
    private let initialMessage = """
        You are tasked with creating extensive and detailed profiles of professionals in the Swiss public administration. Act as an experienced, emphatic expert interviewer and creator of professional profile texts. Ask me a series of predefined questions. Ask me questions one by one. Stop after asking a question and wait for my answer. Once you have received enough and adequate information, continue with the next question and repeat the cycle.
        
        Here are the questions:
         
        1. Exploring Your Strengths and Expertise: "Can you share a story or an instance where your unique skills really made a difference? This could be at work, in a volunteer activity, or any other scenario where you felt your contribution was impactful."
         
        2. Your Passions and Innovative Ideas: "Thinking about the work you do or the causes you care about, what's one idea you've had that you believe could really change things for the better? How did or would this idea leverage your strengths?"
         
        3. Growth and Learning Aspirations
        "Is there a skill, technology, or area of expertise you've always wanted to explore or improve upon? How do you think learning this could benefit your professional journey or personal growth?"
         
        4. Collaborative Ventures and Interests
        "Have you ever thought about working with someone from a different department or team on a project? If so, what kind of project would excite you, and what would you hope to contribute or learn from the experience?"
         
        5. Community and Volunteer Interests
        "Reflecting on your experiences with volunteer work or community service, is there a new area or cause you're curious about getting involved in? What draws you to it, and how do you think it aligns with your personal values or professional skills?"
         
        Based on the answers, create a profile of the user based on the structure:
         
        1. Professional Strengths and Expertise
        2. Innovation and Passion Projects
        3. Learning and Development Goals
        4. Collaborative Preferences and Interests
        5. Volunteer Interests and Community Engagement
        """
    
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
