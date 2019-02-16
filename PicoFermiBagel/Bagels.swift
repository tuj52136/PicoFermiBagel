//
//  Bagels.swift
//  PicoFermiBagel
//
//  Created by Leo Vergnetti on 2/14/19.
//  Copyright © 2019 Leo Vergnetti. All rights reserved.
//
import Foundation


/**The Bagels class is the main class responsible for Pico, Ferm, Bagel.
 When playGame is called, a secret number is generated, and the user
 is prompted to input a guess. A hint is generated for the user, writing
 pico if a digit is in the right place, pico if a digit is correct but
 in the wrong place, or bagel if no digits are correct.
 */

class Bagels{
    
    private var secretNumber = [Int]()
    private var previousGuessesAndHints = [String](){
        didSet{ //Whenever we add a new hint, print the list of hints
            for hint in previousGuessesAndHints{
                print(hint)
            }
        }
    }
    
    /** When playGame is called, a secret number is generated, and the user
     is prompted to input a guess. A hint is generated for the user, writing
     pico if a digit is in the right place, pico if a digit is correct but
     in the wrong place, or bagel if no digits are correct.*/
    public func playGame(){
        generateSecretNumber()
        var numberOfUserGuesses = 0
        print("Hi, I have a number on mind, guess that number?")
        while true {
            if let userGuess = readLine(){
                if userGuess.lowercased() == "quit"{
                    print("You quit after \(numberOfUserGuesses) guesses")
                    break;
                }
                if let _ = Int(userGuess), userGuess.count == 3{
                    numberOfUserGuesses += 1
                    if isUserGuessCorrect(guess: userGuess) {
                        print("You won! It took you : \(numberOfUserGuesses) guesses!")
                        break;
                    } else{
                        printHint(guess: userGuess)
                    }
                } else{
                    print("Not a valid guess.  Please enter a three digit number")
                }
            }
        }
    }
    
    /** Generate secret number creates a 3 digit integer and stores it
     in an array, with each digit an entry.  The first digit is larger
     than one, and each digit is distinct.
     */
    private func generateSecretNumber(){
        secretNumber.append(1 + Int(arc4random_uniform(9)))
        while secretNumber.count < 3 {
            let digit = Int(arc4random_uniform(10))
            if  !secretNumber.contains(digit){
                secretNumber.append(digit)
            }
        }
    }
    
    
    /** Determines whether the user guess is correct.  First creates
     an integer array from the guess, and then checks whether this
     array is the system generated number.
     */
    private func isUserGuessCorrect(guess : String) -> Bool {
        let userGuess = guess.map({Int(String($0))!})
        return secretNumber == userGuess
    }
    
    
    /** Accepts the users guess and gives prints a hint.  For each
     element in the guess, we first check if it equals the corresponding
     element in the secret number.  If so, we print fermi at the start
     of the hint.  If not, we check to see whether each the corresponding
     digit in the secret number is present in the guess.  If so, we print
     pico at the end of the hint.  Finally, if the hint is empty, we print
     bagel, else we print the hint we created.
     */
    private func printHint(guess: String){
        //Generate and format hint
        let userGuess = guess.map({Int(String($0))!})
        var hint = ""
        for index in userGuess.indices{
            if secretNumber[index] == userGuess[index]{
                hint = "Fermi " + hint
            }else if userGuess.contains(secretNumber[index]){
                hint += "Pico "
            }
        }
        hint = hint.isEmpty ? "You guessed \(guess), Bagel" : "You guessed \(guess), \(hint)"
        previousGuessesAndHints += [hint]
    }
}

