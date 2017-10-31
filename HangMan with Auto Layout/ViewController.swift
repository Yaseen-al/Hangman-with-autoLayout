//
//  ViewController.swift
//  HangMan with Auto Layout
//
//  Created by C4Q on 10/28/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    var hangman = HangManModel()
    @IBOutlet weak var outputImage: UIImageView!
    @IBOutlet weak var wordLogOutput: UILabel!
    @IBOutlet weak var scoreLogOutput: UILabel!
    @IBOutlet weak var outputMessage: UILabel!
    
    @IBOutlet weak var onePlayerButtonOuput: UIButton!
    @IBOutlet weak var twoPlayerButtonOutput: UIButton!
    
    
    @IBOutlet weak var textFieldCharacterInput: UITextField!
    
    @IBOutlet weak var textFieldTwoPlayerInput: UITextField!
    
    
    @IBAction func newGameButton(_ sender: Any) {
        hangman.initalizingWord()
        textFieldCharacterInput.isHidden = true
        textFieldTwoPlayerInput.isHidden = true
        wordLogOutput.isHidden = true
        scoreLogOutput.isHidden = true
        wordLogOutput.text = hangman.PlayerOne.myCurrentWord
        outputImage.image = #imageLiteral(resourceName: "count 0")
        onePlayerButtonOuput.isHidden = false
        twoPlayerButtonOutput.isHidden = false
    }
    
    @IBAction func OnePlayerButton(_ sender: Any) {
        hangman.currentUserWord = myRandomWordClass.getMeRandomWord()
        // testing print
        print(hangman.currentUserWord)
        hangman.initalizingWord()
        twoPlayerButtonOutput.isHidden = true
        textFieldCharacterInput.text = ""
        wordLogOutput.isHidden = false
        scoreLogOutput.isHidden = false
        outputMessage.text = "Please Enter your character"
        outputMessage.isHidden = false
        textFieldCharacterInput.isHidden = false
        onePlayerButtonOuput.isHidden = true
    }
    
    @IBAction func TwoPlayerButton(_ sender: Any) {
        textFieldTwoPlayerInput.isHidden = false
        twoPlayerButtonOutput.isHidden = true
        textFieldTwoPlayerInput.text = ""
        textFieldCharacterInput.text = ""
        wordLogOutput.isHidden = false
        scoreLogOutput.isHidden = false
        outputMessage.text = "Please Enter your word"
        outputMessage.isHidden = false
        onePlayerButtonOuput.isHidden = true

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.textFieldTwoPlayerInput:
            guard let inputWord = textField.text?.lowercased()else{
                return false
            }
            hangman.currentUserWord = inputWord
            print(inputWord)
            print(hangman.PlayerOne.myCurrentWord)
            hangman.initalizingWord()
            wordLogOutput.text = hangman.PlayerOne.myCurrentWord
            textFieldCharacterInput.isHidden = false
            textFieldTwoPlayerInput.isHidden = true
            return true
        case self.textFieldCharacterInput:
            print(hangman.PlayerOne.myCurrentWord)
            let myCharacterSet = CharacterSet.symbols
            guard let inputCharacter = textField.text?.lowercased()else{
                return false
            }
//            guard !myCharacterSet.contains(inputCharacter.unicodeScalars.first!) else {
//                return false
//            }
            // I need a function that checks that innput from the text field and compare it with the word
            // and return Players, string that either have the character and _____ and bool of winning as will as if he is active or not
            if hangman.PlayerOne.active{
                let myPlayer = hangman.myPlayerCheck(userInputSting: inputCharacter)
                outputMessage.text = myPlayer.playerMessage
                print(myPlayer.playerMessage)
                print(hangman.counter, myPlayer.winStatus.rawValue)
                switch myPlayer.winStatus {
                case .lose:
                    outputMessage.text = "You Have Lost"
                    wordLogOutput.text = hangman.currentUserWord
                    textFieldCharacterInput.isHidden = true
                case .win:
                    outputMessage.text = "You Have Won"
                    scoreLogOutput.text = "Score \(hangman.PlayerOne.score)"
                    outputImage.image = #imageLiteral(resourceName: "won")
                    scoreLogOutput.isHidden = false
                    wordLogOutput.text = hangman.PlayerOne.myCurrentWord
                    textFieldCharacterInput.isHidden = true
                    return true
                case .playing:
                    wordLogOutput.text = hangman.PlayerOne.myCurrentWord
                    
                }
                switch hangman.counter{
                case 0:
                    break
                case 1:
                    outputImage.image = #imageLiteral(resourceName: "count 1")
                case 2:
                    outputImage.image = #imageLiteral(resourceName: "count 2")
                case 3:
                    outputImage.image = #imageLiteral(resourceName: "count 3")
                case 4:
                    outputImage.image = #imageLiteral(resourceName: "count 4")
                case 5:
                    outputImage.image = #imageLiteral(resourceName: "count 5")
                case 6:
                    outputImage.image = #imageLiteral(resourceName: "count 6")
                default :
                    outputImage.image = #imageLiteral(resourceName: "count 7")
                    
                }
            }
            return true
        default:
            break
        }
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.textFieldCharacterInput.delegate = self
        self.textFieldTwoPlayerInput.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }  
    
    
}

