//  BackgroundViewController.swift
//  Tic Tac Toe First Try
//  Created by Zhaoyang Liu on 1/1/21.
import UIKit
import SafariServices

class BackgroundViewController: UIViewController {
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var label: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var moreButton: UIButton!
    
    // MARK: - Segmented Control and UI Update
    func updateLabel() {
        let index = segmentedControl.selectedSegmentIndex
        if index == 0 {
            label.isHidden = false
            scrollView.isHidden = true
            tableView.isHidden = true
            moreButton.isHidden = false
            
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.clear
            
            label.text = ruleText
        } else if index == 1 {
            label.isHidden = true
            scrollView.isHidden = false
            tableView.isHidden = true
            moreButton.isHidden = true
            
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.clear
        }
        else if index == 2 {
            label.isHidden = true
            scrollView.isHidden = true
            tableView.isHidden = false
            moreButton.isHidden = true
            
            //Enable the bar button "edit" only when the user is in "History" segment, disable and hide the button in other segments
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.systemBlue
            
            //label.text = choices[index-1].text
        }
    }
    
    // MARK: - Rule
    //Reference to the Tic Tac Toe Wikipedia page
    @IBAction func moreButtonTapped(_ sender: UIButton) {
        if let url = URL(string: "https://en.wikipedia.org/wiki/Tic-tac-toe") {
            let safariViewController = SFSafariViewController(url: url)
            
            present(safariViewController, animated: true, completion: nil)
        }
    }

    // MARK: - Graphical Illustration
    //Initalize an arrary of images
    var imageChoices = [UIImage]()
    
    func imageScrollView() {
        imageChoices = [#imageLiteral(resourceName: "Xwins"),#imageLiteral(resourceName: "O Wins") ,#imageLiteral(resourceName: "Draw") ]
        
        //Start from 0 and loop through the imageChoices the exact number of times as the count of pictures in the array.
        //"..<" insures it is the right amount of time
        for i in 0..<imageChoices.count {
            let imageView = UIImageView()
            imageView.image = imageChoices[i]
            
            imageView.contentMode = .scaleAspectFit
            
            //Defines the frame of the imageView.
            
            //xPosition defines the x axis of the imageView.
                //When the first image is displayed, we want it all the way to the left on the screen, so i=0 times anything would give us a x value of 0.
                //When the second image is displayed, xPosition would be 1 times the width of the screen, which would put the seocnd image onto the next page
            
            //Define y position to be 0 so the imageView will stick to the upper left corner
            let xPosition = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition,
                                     y: 0,
                                     width: self.scrollView.frame.width,
                                     height: self.scrollView.frame.height-100)
            
            scrollView.contentSize.width = scrollView.frame.width * CGFloat(Double(i)+1)
            scrollView.addSubview(imageView)
        }
    }

    // MARK: - Histroy Information
    //Initalize an arrary of introduction under the "History" section
    var historyInfo: [History] = [History(symbol: "🇪🇬", region: "Egypt", time: "1300 BCE", description: egyptText),
                                  History(symbol: "👑", region: "Romans", time: "1st Century", description: romansText ),
                                  History(symbol: "🇬🇧", region: "England", time: "18th Century", description: englandText),
                                  History(symbol: "🌍", region: "Worldwide", time: "Today", description: worldwideText)]
    
    var specificInfo: [String] = [egyptText, romansText, englandText, worldwideText]
    var indexForReference = 0

    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        
        tableView.setEditing(!tableViewEditingMode, animated: true)
        
        //Toggle the text of the UIBarButtonItem to reflect the status
        if sender.title == "Edit" {
            sender.title = "Done"
        } else {
            sender.title = "Edit"
        }
    }
    
    //Give users the ability to move and organize the cells in the order they want
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedIntro = historyInfo.remove(at: sourceIndexPath.row)
        
        historyInfo.insert(movedIntro, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    //Hide the delete indicator
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
                
        segmentedControl.selectedSegmentIndex = 0
        
        //Illustration
        imageScrollView()
        
        //History
        tableView.delegate = self
        tableView.dataSource = self
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
        updateLabel()
    }
    
    @IBAction func choiceSelected(_ sender: Any) {
        updateLabel()
    }
    
    //The following function is called everytime "segueToSpecificInfo" performs, and it passes the arrary "historyInfo" and "indexForReference" to the SpecificInfoViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SpecificInfoViewController
        vc.info = self.historyInfo
        vc.indexforReference = self.indexForReference
    }
    
    // MARK: - View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewDidAppear(animated)
    }
}

// MARK: - Table View Data Source

extension BackgroundViewController: UITableViewDataSource {
    //Return 1 since there are no seperate sections in the table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //The number of rows in the table view is depended on how many subjects there are in the historyInfo array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
        
        let info = historyInfo[indexPath.row]
        cell.textLabel?.text = "\(info.symbol) - \(info.region)"
        cell.detailTextLabel?.text = "\(info.time)"
        
        return cell
    }
}

extension BackgroundViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //For example, when tapping on the first row, index for reference would be 0. And it gives us a way to access that item in the view controller
        indexForReference = indexPath.row
        
        performSegue(withIdentifier: "segue", sender: self)
    }
}
