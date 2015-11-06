//
//  FiltersViewController.swift
//  ajudae
//
//  Created by Moisés Pio on 11/6/15.
//  Copyright © 2015 Moisés Pio. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewContainer: UIView!
    
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
        return  5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! FiltersTableViewCell
        
        switch indexPath.row {
        case 0 :
            cell.labelTitle.text = "Eletrodomésticos"
            cell.labelDescription.text = "145 itens publicados"
            cell.imageIcon.image = UIImage(named: "FilterIcon1")
            break
        case 1 :
            cell.labelTitle.text = "Material de construção"
            cell.labelDescription.text = "85 itens publicados"
            cell.imageIcon.image = UIImage(named: "FilterIcon2")
            break
        case 2 :
            cell.labelTitle.text = "Mobília"
            cell.labelDescription.text = "34 itens publicados"
            cell.imageIcon.image = UIImage(named: "FilterIcon3")
            break
        case 3 :
            cell.labelTitle.text = "Roupas"
            cell.labelDescription.text = "78 itens publicados"
            cell.imageIcon.image = UIImage(named: "FilterIcon4")
            break
        case 4 :
            cell.labelTitle.text = "Outros"
            cell.labelDescription.text = "12 itens publicados"
            cell.imageIcon.image = UIImage(named: "FilterIcon5")
            break
        default :
            break
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
