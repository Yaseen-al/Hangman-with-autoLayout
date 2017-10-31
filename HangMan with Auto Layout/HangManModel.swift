//
//  HangManModel.swift
//  HangMan with Auto Layout
//
//  Created by C4Q on 10/28/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation
// creating my player struct to use its information as a teack of player score
enum WinningStatus:String{
    case win, lose, playing
}
struct Player {
    var score: Int
    var name: String
    var active: Bool
    var winStatus: WinningStatus
    //this is my progress on the word that I am working on
    var myCurrentWord: String
    var playerMessage: String
    //setting my reseting reseting function
    mutating func reset(){
        self.name = ""
        self.score = 0
        self.active = false
        self.myCurrentWord = ""
        self.winStatus = .playing
        self.playerMessage = ""
    }
    // setting a reset for my Player
    mutating func setPlayer(name: String, score: Int, active: Bool,myCurrentWord: String, winStatus: WinningStatus,playerMessage: String){
        self.name = name
        self.score = score
        self.active = active
        self.myCurrentWord = myCurrentWord
        self.winStatus = winStatus
        self.playerMessage = playerMessage
    }
}
var myRandomWordClass = HangManWordResource()
class HangManModel{
    var playerOne = Player(score: 0, name: "New Player", active: true, winStatus: .playing, myCurrentWord: "word", playerMessage: "This is my intial message")
    private let myRandmoWord = myRandomWordClass.getMeRandomWord()
    var counter = 0
    var currentUserWord = "peace"
    var wordToArray:[String] = []
    // I neeed a function that inialize the word(- - - -)
    func initalizingWord(){
        let wordToArray = Array(currentUserWord)
        let playerOneIntialWord = Array(repeating: "_", count: wordToArray.count)
        playerOne.myCurrentWord = playerOneIntialWord.joined()
        playerOne.active = true
        playerOne.winStatus = .playing
        counter = 0
    }
    // myCmparisonFunction that will return a player with numberOfTrials, active, score, winningStatus and will only take a string which is a character from the UItext
    func myPlayerCheck(userInputSting: String) -> Player {
        // && userInputSting.count == 1  tooked it out from guard for testing
        guard counter < 7  else{
            playerOne.active = false
            playerOne.winStatus = .lose
            playerOne.playerMessage = "You Lose"
            return playerOne
        }
        let wordToArray = Array(currentUserWord)
        var playerWordToArray = Array(playerOne.myCurrentWord)
        // checking if current word have the input character as well player's word doesn't have the character
        if currentUserWord.contains(userInputSting) && !playerOne.myCurrentWord.contains(userInputSting){
            for i in 0..<wordToArray.count{
                if userInputSting == String(wordToArray[i]){
                    playerWordToArray[i] = Character(userInputSting)
                }
            }
            playerOne.myCurrentWord = String(playerWordToArray)
            print("this is the updated playerOne currentWord\(playerOne.myCurrentWord)")
            // I have a problem with the right scenario as the word array is intailized every time the function is called
            
            playerOne.playerMessage = "That's right"
            playerOne.winStatus = .playing
            if !playerOne.myCurrentWord.contains("_"){
                playerOne.active = false
                playerOne.playerMessage = "You Have Won"
                playerOne.score += 1
                playerOne.winStatus = .win
            }
        }
        // losing condition
        if !currentUserWord.contains(userInputSting){
            counter += 1
            playerOne.playerMessage = "Wrong"
            if counter >= 7{
                playerOne.active = false
                playerOne.winStatus = .lose
                playerOne.playerMessage = "Wrong Character You Lose"
                return playerOne
            }
            
        }
        return playerOne
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
