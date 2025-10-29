//
//  ItemView.swift
//  Test playgrounds
//
//  Created by Robert Goedman on 10/24/25.
//

import SwiftUI
import SwiftData
import FoundationModels

struct ItemView {
  @Binding var prompt: String
  @Binding var response: String
  @Environment(\.modelContext) private var modelContext
  @Environment(\.dismiss) private var dismiss
  @State private var session = LanguageModelSession()
  var item: Item
}

extension ItemView: View {
    var body: some View {
      VStack {
        Spacer()
        TextField("Prompt", text: $prompt, axis: .vertical)
          .fontWidth(.init(7))
          .padding()
        Spacer()
        TextField("Response", text: $response, axis: .vertical)
          .fontWidth(.init(5))
          .padding()
        Spacer()
      }
      Spacer()
      HStack {
        Spacer()
        Button("Generate response") {
          Task {
            await updateResponse(prompt)
          }
        }
        Spacer()
        Button("Clean up") {
          response = ""
          prompt = ""
        }
        Spacer()
        Button("Dismiss") {
          item.timestamp = Date()
          item.prompt = prompt
          item.response = response
          do {
            try modelContext.save()
          } catch {
            print(error.localizedDescription)
          }
          dismiss()
        }
        Spacer()
      }
    }
}
  
  extension ItemView {
    func updateResponse(_ prompt: String) async {
      do {
        response = try await session.respond(to: prompt).content
      } catch {
        print(error.localizedDescription)
      }
    }
  }



#Preview {
  ItemView(prompt: .constant("No prompt yet!"),
           response: .constant("No response yet!"),
           item: Item(
    timestamp: Date(),
    prompt: "No prompt yet!",
    response: "No response yet!"))
}
