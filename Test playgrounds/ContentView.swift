//
//  ContentView.swift
//  Test playgrounds
//
//  Created by Robert Goedman on 10/16/25.
//

import SwiftUI
import SwiftData

struct ContentView {
  @State private var isLLMVisible: Bool = false
  @State private var isAddItemViewVisible: Bool = false
  @State private var prompt: String = ""
  @State private var response: String = ""
  @Environment(\.modelContext) private var modelContext
  @Query private var items: [Item]
}

extension ContentView: View {
  var body: some View {
    NavigationStack {
      List {
        ForEach(items) { item in
          NavigationLink(item.prompt,
                         value: item)
        }
        .onDelete(perform: deleteItems)
      }
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button {
            isAddItemViewVisible = true
          } label: {
            Label("Add item", systemImage: "plus")
          }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          EditButton()
        }
      }
      .navigationDestination(for: Item.self) { item in
        viewItem(item: item)
      }
    }
    .sheet(isPresented: $isAddItemViewVisible) {
      LLMView(isLLMVisible: $isLLMVisible)
    }
  }
  
  private func viewItem(item: Item) -> some View {
    prompt = item.prompt
    response = item.response
    return ItemView(prompt: $prompt,
             response: $response,
             item: item)

  }
  
  private func addItem() {
    withAnimation {
      let newItem = Item(timestamp: Date())
      modelContext.insert(newItem)
    }
  }
  
  private func deleteItems(offsets: IndexSet) {
    withAnimation {
      for index in offsets {
        modelContext.delete(items[index])
      }
    }
  }
}

#Preview {
  ContentView()
    .modelContainer(for: Item.self, inMemory: true)
}
