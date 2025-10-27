//
//  Item.swift
//  Test playgrounds
//
//  Created by Robert Goedman on 10/16/25.
//

import Foundation
import SwiftData

@Model
final class Item {
  var timestamp: Date = Date()
  var prompt: String = ""
  var response: String = ""
    
    init(timestamp: Date,
         prompt: String = "",
         response: String = "") {
      self.timestamp = timestamp
      self.prompt = prompt
      self.response = response
    }
}
