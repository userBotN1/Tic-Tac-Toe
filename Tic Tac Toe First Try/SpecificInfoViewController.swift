//  SpecificInfoViewController.swift
//  Tic Tac Toe First Try
//  Created by Zhaoyang Liu on 1/3/21.
import UIKit
class SpecificInfoViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var info = [History]()
    var indexforReference: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = info[indexforReference].region
        timeLabel.text = info[indexforReference].time
        descriptionLabel.text = info[indexforReference].description
    }
}
