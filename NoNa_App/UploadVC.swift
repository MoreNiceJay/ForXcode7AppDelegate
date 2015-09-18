//
//  UploadVC.swift
//  NoNa_App
//
//  Created by Lee Janghyup on 9/4/15.
//  Copyright (c) 2015 jay. All rights reserved.
//

import UIKit
import Parse

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageViewPreview: UIImageView!
    @IBOutlet weak var textFieldPreviewTitle: UITextField!
    
   
    
        
        
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        textFieldPreviewTitle.resignFirstResponder()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func uploadPhoto(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = false
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imageViewPreview.image = image
    
        self.dismissViewControllerAnimated(true, completion: nil)
            
    }
    
    /* //스케일 조절
    func scaleImageWith(image : UIImage,  newSize : CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height ))
        var newImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
*/
    
    func scaleImageWith(image : UIImage, newSize : CGSize) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    

    
    @IBAction func uploadButtonTapped(sender: AnyObject) {
        print("업로드 시작")
        
        let imageText = textFieldPreviewTitle.text
        let previewIamge = imageViewPreview.image
        
        
        if imageText!.isEmpty || previewIamge == nil {
            
        
         //유저에게 채워넣으라고 알럴트
            print("업로드: 유저가 이미지 혹은 텍스트를 넣지않음")
            
        }else {
            //스케일 조절
           // let scaledImage = self.scaleImageWith(previewIamge!, and CGSizeMake(960, 490))
            
            let scaledImage = self.scaleImageWith(previewIamge!, newSize: CGSizeMake(460, 280))
        
            
            let imageData = UIImagePNGRepresentation(scaledImage)
            let paseImageFile = PFFile(name: "uploaded_image.png", data : imageData!)
            
            
            let save = PFObject(className: "Posts")
            save["imageFile"] = paseImageFile
            save["imageText"] = imageText
            save["uploader"] = PFUser.currentUser()
            save["username"] = PFUser.currentUser()!.username
            save.saveInBackgroundWithBlock({ ( isSucessful: Bool, error : NSError?) -> Void in
               
                
                if error == nil {
                    
                    print("업로드 성공")
                    
                    //저장 성공했다고 표시창
                    self.performSegueWithIdentifier("uploadToHome", sender: self)
                    
                    
                }else { print(error)
                }
            })
            
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

}
