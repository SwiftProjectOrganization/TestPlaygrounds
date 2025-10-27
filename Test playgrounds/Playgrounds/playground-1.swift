//
//  playground-3.swift
//  Test playgrounds
//
//  Created by Robert Goedman on 10/16/25.
//

import Foundation
import FoundationModels
import Playgrounds

#Playground {
  // Create a new session with the language model.
  let session = LanguageModelSession()

  // Asynchronously generate a response from a text prompt.
  let response = try await session.respond(to: "List 3 important components of the nervous system.")
}

#Playground {
    // Create a new session with the language model.
    let session = LanguageModelSession()

    // Asynchronously generate a response from a text prompt.
    let response = try await session.respond(to: "List important functions of neurons.")
}

#Playground {
    // Create a new session with the language model.
    let session = LanguageModelSession()

    // Asynchronously generate a response from a text prompt.
    let response = try await session.respond(to: "List 3 important functions of neurons.")
}

#Playground {
    // Create a new session with the language model.
    let session = LanguageModelSession()

    // Asynchronously generate a response from a text prompt.
    let response = try await session.respond(to: "What are the functions of cortisol.")
}
