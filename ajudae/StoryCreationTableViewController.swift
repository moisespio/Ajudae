//
//  StoryCreationTableViewController.swift
//  ajudae
//
//  Created by Rafael Valer on 11/6/15.
//  Copyright © 2015 Moisés Pio. All rights reserved.
//

import UIKit
import Parse

class StoryCreationTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var txtFieldTitle: UITextField!
    @IBOutlet weak var txtFieldStory: UITextView!
    @IBOutlet weak var storyImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addPhoto(sender: AnyObject) {
        print("add")
        let alert : UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let picker : UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        let take : UIAlertAction = UIAlertAction(title: "Take Photo", style: UIAlertActionStyle.Default){ (action) -> Void in
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            
            self.presentViewController(picker, animated: true, completion: nil)
        }
        
        let choose : UIAlertAction = UIAlertAction(title: "Choose Photo", style: UIAlertActionStyle.Default){ (action) -> Void in
            
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            picker.view.bounds.size.height = CGFloat()
            
            self.presentViewController(picker, animated: true, completion: nil)
        }
        let cancel : UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alert.addAction(take)
        alert.addAction(choose)
        alert.addAction(cancel)
        
        self.presentViewController(alert, animated: true) { () -> Void in
            
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.storyImage.image = image
        self.storyImage.contentMode = UIViewContentMode.ScaleAspectFill
        self.storyImage.clipsToBounds = true
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func addStory(sender: AnyObject) {
        if let storyTitle = txtFieldTitle.text, storyStory = txtFieldStory.text {
            let newStory = Story()
            
            newStory.title = storyTitle
            newStory.story = storyStory
            
            if let image = self.storyImage.image {
                guard let data = UIImageJPEGRepresentation(image, 1) else {
                    return
                }
                newStory.image = PFFile(data: data)
            }
            
            newStory.saveInBackgroundWithBlock({ (result, error) -> Void in
                print(result)
            })
        }
        
        
    }
    // MARK: - Table view data source

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
