//  ResultViewController.swift
//  Tic Tac Toe First Try
//  Created by Zhaoyang Liu on 1/4/21.
import UIKit
class ResultViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    var resultIndicator = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        if resultIndicator == 1 {
            imageView.image = UIImage(named: "X")
            resultLabel.text = "WINNER!"
        } else if resultIndicator == 2 {
            imageView.image = UIImage(named: "O")
            resultLabel.text = "WINNER!"
        } else if resultIndicator == 3 {
            imageView.image = UIImage(named: "Draw Result")
            resultLabel.text = "DRAW!"
        }
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //Give user the ability to share this app with others 
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        let shareStatement = "I am playing Tic Tac Toe.\nCome join me for a match of the classical game now!"
        let activityController = UIActivityViewController(activityItems: [shareStatement], applicationActivities: nil)
        
        activityController.popoverPresentationController?.sourceView = sender
        present(activityController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewDidAppear(animated)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gameVC = segue.destination as! GameViewController
        
        gameVC.count = 0
        gameVC.activeGame = true
        gameVC.currentPlayer = 1
        gameVC.result = 0
    }
}
