//  ViewController.swift
//  Tic Tac Toe First Try
//  Created by Zhaoyang Liu on 1/1/21.

import UIKit
class IntroductionViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Hide the navigation bar in UI for better visual effect
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewDidAppear(animated)
    }
}
