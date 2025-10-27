//
//  playground-2.swift
//  Test playgrounds
//
//  Created by Robert Goedman on 10/23/25.
//

import Foundation
import Playgrounds

#Playground("Actor example") {
  actor BankAccount {
    private var balance = 0
    
    func deposit(_ amount: Int) {
      balance += amount
    }
    
    func getBalance() -> Int {
      return balance
    }
  }
  
  let account = BankAccount()
  
  func getBalance() async {
    print(await account.getBalance())
  }
  
  func deposit(_ amount: Int) async {
    await account.deposit(amount)
  }
  
  func run() {
    Task {
      await deposit(100)
      await getBalance()
    }
  }
  
  run()
}
