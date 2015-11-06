//
//  ViewController.swift
//  ajudae
//
//  Created by Moisés Pio on 11/5/15.
//  Copyright © 2015 Moisés Pio. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  4
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.tableView.frame.height/4 - (self.navigationController?.navigationBar.frame.height)!/4 - 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MainTableViewCell
        
        switch indexPath.row {
            case 0 :
                cell.backgroundColor = UIColor.rosa
            break
            case 1 :
                cell.backgroundColor = UIColor.laranja
            break
            case 2 :
                cell.backgroundColor = UIColor.azul
            break
            case 3 :
                cell.backgroundColor = UIColor.azulbebe
            break
            default :
            
            break
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("donations", sender: nil)
    }
}

