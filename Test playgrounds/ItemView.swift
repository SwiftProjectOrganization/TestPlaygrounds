//
//  ItemView.swift
//  Test playgrounds
//
//  Created by Robert Goedman on 10/24/25.
//

import SwiftUI

struct ItemView {
  @Binding var prompt: String
  @Binding var response: String
  var item: Item
}

extension ItemView: View {
    var body: some View {
      VStack {
        Spacer()
        TextField("Prompt", text: $prompt, axis: .vertical)
          .padding()
        Spacer()
        TextField("Response", text: $response, axis: .vertical)
          .padding()
        Spacer()
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
