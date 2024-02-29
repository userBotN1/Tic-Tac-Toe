//  GameViewController.swift
//  Tic Tac Toe First Try
//  Created by Zhaoyang Liu on 1/2/21.
import UIKit
class GameViewController: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    
    // MARK: - Initialize variables
    var currentPlayer = 1 //One represents cross, and two represents circle
    var activeGame = true
    
    //Result is an integer representing the result of one round of tic tac toe.
    //It is send to the Result View Controller everytime the "segueToResult" performs so the result of each round could be properly displayed in the Result View Controller
    var result: Int = 0
    var count = 0
    
    // MARK: - One Rond of Tic Tac Toe
    //The following funciton is called everytime the user pressed a button on the grid.
    @IBAction func buttonTappedAction(_ sender: AnyObject) {
        //The function is first checking if the game is still active and if the location the user pressed is still empty
        if gameState[sender.tag] == -1 && activeGame == true {
            gameState[sender.tag] = currentPlayer
            if currentPlayer == 1 {
                sender.setImage(UIImage(named: "X"), for: UIControl.State())
                currentPlayer = 2
                textLabel.text = "O Turn"
                count+=1

            } else {
                sender.setImage(UIImage(named: "O"), for: UIControl.State())
                currentPlayer = 1
                textLabel.text = "X Turn"
                count+=1
            }
        }
        
        //The function then checks if a winning condition occured
        //Once we have a winner, the game status would no longer be active and the segue to the Result View Controller would be performed
        for condition in winningCondition {
            print("checking for step \(count)")
            
            if gameState[condition[0]] != -1 && gameState[condition[0]] == gameState[condition[1]] && gameState[condition[1]] == gameState[condition[2]] {
                print("reached the if statement")
                
                activeGame = false
                
                //Check who the winner is
                if gameState[condition[0]] == 1 {
                    result = 1
                    break
                } else if gameState[condition[0]] == 2 {
                    result = 2
                    break
                }
            } else if count == 9 {
                activeGame = false
                result = 3
                break
            }
        }
    
        if activeGame == false {
                performSegue(withIdentifier: "segueToResult", sender: self)
        }
    }
    
    //The following function is called everytime "segueToResult" performs, and it passes the integer "resultIndicator" and to the ResultViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ResultViewController
        vc.resultIndicator = self.result
    }

    func resetUI() {
        gameState = [-1, -1, -1, -1, -1, -1, -1, -1, -1]
        activeGame = true
        currentPlayer = 1
        result = 3
        count = 0
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        resetUI()
    }
    
    //Hide the navigation bar in UI for better visual effect
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewDidAppear(animated)
    }
}
