//
//  ViewController.swift
//  Word Garden
//
//  Created by Daniel Lu on 9/17/17.
//  Copyright © 2017 Daniel Lu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var wordToGuess = "SWIFT"
    var lettersGuessed = ""
    let maxNumberofWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var userGuessCount = 0
    
    
    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessedLetterField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
        formatUserGuessLabel()
    }
    
    func updateUIAfterGuess() {
        guessedLetterField.resignFirstResponder()
        guessedLetterField.text = ""
        guessLetterButton.isEnabled = false
    }
    func formatUserGuessLabel() {
        var revealedWord = ""
        lettersGuessed += guessedLetterField.text!
        
        for letter in wordToGuess {
            if lettersGuessed.contains(letter) {
                revealedWord = revealedWord + "  \(letter)"
            } else {
                revealedWord += " _"
            }
        }
        revealedWord.removeFirst()
        userGuessLabel.text = revealedWord
    }
    
    func guessALetter() {
        formatUserGuessLabel()
        userGuessCount += 1
        
        let currentLetterGuessed = guessedLetterField.text!
        if !wordToGuess.contains(currentLetterGuessed) {
            wrongGuessesRemaining = wrongGuessesRemaining - 1
            flowerImageView.image = UIImage(named: "flower\(wrongGuessesRemaining)")
        }
        let revealedText = userGuessLabel.text!
        if wrongGuessesRemaining == 0 {
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "You Lose"
        } else if !revealedText.contains("_") {
            //Win game
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "You win in \(userGuessCount) tries"
        }
        else {
            let guess = ( userGuessCount == 1 ? "guess" : "guesses")
            guessCountLabel.text = "You've made \(userGuessCount) \(guess)"
        }
    }
    
    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        if let letterGuessed = guessedLetterField.text?.last {
            guessedLetterField.text = "\(letterGuessed)"
            guessLetterButton.isEnabled = true
        } else {
            //disable button if no characters in guessdLetterField
            guessLetterButton.isEnabled = false
        }
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        playAgainButton.isHidden = true
        guessedLetterField.isEnabled = true
        guessLetterButton.isEnabled = false
        flowerImageView.image = UIImage(named: "flower8")
        wrongGuessesRemaining = maxNumberofWrongGuesses
        lettersGuessed = ""
        formatUserGuessLabel()
        guessCountLabel.text = "You've Made 0 Guesses"
        userGuessCount = 0
    }
    



}

