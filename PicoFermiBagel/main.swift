//
//  main.swift
//  PicoFermiBagel
//
//  Created by Leo Vergnetti on 2/14/19.
//  Copyright © 2019 Leo Vergnetti. All rights reserved.
//

import Foundation

while true {
    let bagels = Bagels()
    bagels.playGame()
    print("Enter 'quit' to quit, or press any key to play again!")
    if let userInput = readLine(), userInput.lowercased() == "quit"{
        break;
    }
}
print("Thanks for playing!")
