//
//  MainHomeTVC.swift
//  NoNa_App
//
//  Created by Lee Janghyup on 9/3/15.
//  Copyright (c) 2015 jay. All rights reserved.
//

import UIKit
import Parse

class MainHomeTVC: UITableViewController {

    var imageFiles = [PFFile]()
    var imageText = [String]()
    var objectIdArray = [String]()
    var userId = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let query = PFQuery(className: "Posts")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (posts :[AnyObject]?, error : NSError?) -> Void in
            if error == nil {
                //에러없는 경우
                
                for post in posts! {
                    
                    self.imageText.append(post["imageText"] as! String)
                    self.imageFiles.append(post["imageFile"] as! PFFile)
                    
                    self.objectIdArray.append((post.objectId)! as String!)
                    //self.userId.append(post["username"] as! String)
                    
                    
                    self.tableView.reloadData()
                }
                
            } else { print(error)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

   
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return imageText.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MainHomeTVCELL

        //제목
        cell.labelTitle.text = imageText[indexPath.row]
       
        //이미지
        imageFiles[indexPath.row].getDataInBackgroundWithBlock { (imageData : NSData?, error : NSError?) -> Void in
            let image = UIImage(data : imageData! )
       
            cell.imagePreview.image = image
            
        //아이디
            
            
        }
        
        
        
        // Configure the cell...

        return cell
    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "goToComment") {
            
            var selectedRowIndex = self.tableView.indexPathForSelectedRow
            var destViewController : CommentVC = segue.destinationViewController as! CommentVC
            
            destViewController.parentObjectId = objectIdArray[(selectedRowIndex?.row)!]
        }
    }
           
            
    
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
