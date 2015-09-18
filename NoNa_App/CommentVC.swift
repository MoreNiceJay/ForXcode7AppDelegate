//
//  ViewController.swift
//  NoNa_App
//
//  Created by Lee Janghyup on 9/17/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class CommentVC: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableViewComment: UITableView!
    @IBOutlet weak var textFieldComment: UITextField!
    var parentObjectId : String = String()
    var commentArray = [String]()
    var userIdArray = [String]()
    
    
    @IBAction func commentUploadButtonTapped(sender: AnyObject) {
        
        let comment = PFObject(className: "Comments")
        
        comment["comment"] = "" + textFieldComment.text!
        comment["parent"] = parentObjectId
        comment["username"] = PFUser.currentUser()?.username
        
        comment.saveInBackgroundWithBlock { (success : Bool, error : NSError?) -> Void in
            if error == nil {
                
                print(self.parentObjectId)
            }
            self.commentArray = []
            self.querryComment()
        }
        
        
        
        
        
    }
    override func viewDidLoad() {
        querryComment()
        
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    func querryComment(){
    let querryComment = PFQuery(className: "Comments")
    
    querryComment.whereKey("parent", equalTo: "\(parentObjectId)")
    querryComment.orderByAscending("createdAt")
    querryComment.findObjectsInBackgroundWithBlock { (comments : [AnyObject]?, error : NSError?) -> Void in
    if error == nil {
    
    for post in comments! {
    
    self.commentArray.append(post["comment"] as! String)
    self.userIdArray.append(post["username"] as! String)
    }
    }else{
    print(error)
    }
    self.tableViewComment.reloadData()
    
    }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell2", forIndexPath: indexPath) 
        
        cell.textLabel!.text = self.commentArray[indexPath.row]
        cell.detailTextLabel?.text = self.userIdArray[indexPath.row]
        
        return cell
    }

    
    
    

}
