//
//  Bagels.swift
//  PicoFermiBagel
//
//  Created by Leo Vergnetti on 2/14/19.
//  Copyright © 2019 Leo Vergnetti. All rights reserved.
//

import Foundation
class Bagels{
    
    var systemNumber : Int?
    
    
    func playGame(){
        generateSecretNumber()
        print("System generated: \(systemNumber!)")
        while true {
            print("Enter a guess")
            if let userGuess = Int(readLine()!){
                if isUserGuessCorrect(guessed: userGuess){
                    print("YOU DID IT")
                    break;
                }else{
                    print("Not Correct")
                    print(userGuess.getDigitsArray())
                }
            }
        }
        
    }
    
    func generateSecretNumber(){
        systemNumber = 100 + Int(arc4random_uniform(900))
    }
    
    func isUserGuessCorrect(guessed userGuess : Int) -> Bool {
        return systemNumber == userGuess
    }
    
    func printHint(guess : Int){
        var fermis = 0
        var picos = 0
        let systemDigits = systemNumber!.getDigitsArray()
        let guessDigits = guess.getDigitsArray()
        for i in 1 ... 3 {
            for j in 1 ... 3{
                if systemDigits[i] == guessDigits[j]{
                    if i == j {
                    }
                }
            }
        }
    }
}

extension Int{
    func getDigitsArray() -> [Int]{
        var ints = [Int]()
        var number = self
        for i in 1 ... 3{
            let divisor = Int(pow(Double(10), Double(3-i)))
            if number >= divisor{
                let currentDigit = Int(Double(number) / pow(Double(10), Double(3 - i)))
                ints += [currentDigit]
                number -= currentDigit * Int(pow(Double(10), Double(3 - i)))
            }else {
                ints += [0]
            }
        }
        return ints
    }
}

