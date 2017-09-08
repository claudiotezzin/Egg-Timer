//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Claudio Tezzin Jeremias on 06/09/17.
//  Copyright © 2017 Claudio Tezzin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var endGameLabel: UILabel!
    
    var activePlayer = 1 //1 - nought, 2 - cross
    
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0] // 0 - empty, 1 - nought, 2 - cross
    
    var isPlaying = true
    
    let winningGames = [[0, 1, 2], [3, 4, 5], [6, 7, 8],
                        [0, 3, 6], [1, 4, 7], [2, 5, 8],
                        [0, 4, 8], [2, 4, 6]]
    
    var playedTimesCounter = 0
    
    @IBAction func playAgain(_ sender: Any) {
        isPlaying = true
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        activePlayer = 1
        playedTimesCounter = 0
        
        endGameLabel.isHidden = true
        playAgainButton.isHidden = true
        
        endGameLabel.center = CGPoint(x: endGameLabel.center.x - 500, y: endGameLabel.center.y)
        playAgainButton.center = CGPoint(x: playAgainButton.center.x - 500, y: playAgainButton.center.y)
        
        for index in 0...9 {
            if let button = self.view.viewWithTag(index) as? UIButton {
                button.setImage(nil, for: [])
            }
        }
    }
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        let position = sender.tag - 1
        
        if gameState[position] == 0 && isPlaying {
            playedTimesCounter += 1
            
            if activePlayer == 1 {
                sender.setImage(UIImage(named: "nought.png"), for:[])
                activePlayer = 2
                gameState[position] = 1
            } else {
                sender.setImage(UIImage(named: "cross.png"), for:[])
                activePlayer = 1
                gameState[position] = 2
            }
            
            validateGame()
        }
    }
    
    func validateGame() {
        for combination in winningGames {
            if gameState[combination[0]] != 0 &&
                gameState[combination[0]] == gameState[combination[1]] &&
                gameState[combination[1]] == gameState[combination[2]] {
                
                isPlaying = false
                endGameLabel.isHidden = false
                playAgainButton.isHidden = false
                
                endGameLabel.textColor = UIColor.green
                
                if(gameState[combination[0]] == 1) {
                    endGameLabel.text = "Noughts has won the Game!"
                } else {
                    endGameLabel.text = "Crosses has won the Game!"
                }
                
                animateEndOfTheGame()
                break
            } else if playedTimesCounter == 9 {
                isPlaying = false
                endGameLabel.isHidden = false
                playAgainButton.isHidden = false
                
                endGameLabel.text = "Its a tie!"
                endGameLabel.textColor = UIColor.yellow
                
                animateEndOfTheGame()
                break
            }
        }
    }
    
    func animateEndOfTheGame() {
        UIView.animate(withDuration: 1, animations: {
            self.endGameLabel.center = CGPoint(x: self.endGameLabel.center.x + 500, y: self.endGameLabel.center.y)
            self.playAgainButton.center = CGPoint(x: self.playAgainButton.center.x + 500, y: self.playAgainButton.center.y)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        endGameLabel.isHidden = true
        playAgainButton.isHidden = true
        
        endGameLabel.center = CGPoint(x: endGameLabel.center.x - 500, y: endGameLabel.center.y)
        playAgainButton.center = CGPoint(x: playAgainButton.center.x - 500, y: playAgainButton.center.y)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

