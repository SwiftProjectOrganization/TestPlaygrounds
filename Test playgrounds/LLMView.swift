//
//  LLMView.swift
//  Test playgrounds
//
//  Created by Robert Goedman on 10/22/25.
//

import SwiftUI
import SwiftData
import FoundationModels

struct LLMView {
  @Binding var isLLMVisible: Bool
  @FocusState private var focusField
  @Environment(\.modelContext) private var modelContext
  @Environment(\.dismiss) private var dismiss
  @State private var session = LanguageModelSession()
  @State private var prompt: String = "What is a neuromodulator?"
  @State private var response: String = ""
}

extension LLMView: View {
    var body: some View {
      Spacer()
      HStack {
        Spacer()
        TextField("Prompt", text: $prompt)
          .padding()
          .background(Color(.systemGray6))
          .cornerRadius(8)
        Spacer()
      }
      Spacer()
      Text(response)
        .padding()
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
          let newItem = Item(timestamp: Date(),
                              prompt: prompt,
                             response: response)
          modelContext.insert(newItem)

          isLLMVisible = false
          dismiss()
        }
        Spacer()
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Button {
              dismiss()
            } label: {
              Label("Back", systemImage: "lessthan")
            }
            .foregroundColor(.black)
          }
        }
      }
    }
}

extension LLMView {
  func updateResponse(_ prompt: String) async {
    do {
      response = try await session.respond(to: prompt).content
    } catch {
      print(error.localizedDescription)
    }
  }
}

#Preview {
  LLMView(isLLMVisible: .constant(true))
}
