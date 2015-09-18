//
//  ViewController.swift
//  NoNa_App
//
//  Created by Lee Janghyup on 8/26/15.
//  Copyright (c) 2015 jay. All rights reserved.
//

import UIKit
import Parse

class ResisterVC: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    func dismissKeboard(textField : UITextField, shouldchangeTextInRange range : NSRange, replacementText text : String) -> Bool{
        
        if text == "\n" {
            passwordTextField.resignFirstResponder()
            usernameTextField.resignFirstResponder()
            emailTextField.resignFirstResponder()
            return true
        }else {
            return false
            
        }
        
        
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        passwordTextField.resignFirstResponder()
        usernameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
           }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func resisterButtonTapped(sender: AnyObject) {
        var username = usernameTextField.text
        var email = emailTextField.text
        var password = passwordTextField.text
        
        
        if username!.isEmpty || email!.isEmpty || password!.isEmpty {
            
            //유저에게 다시 시도하라고 알리기
            print("레지스터페이지 : 유저 빈칸 안채움")
            
        }else {
            //가입허락하기
            var user = PFUser()
            
            user.username = username
            user.email = email
            user.password = password
            user.signUpInBackgroundWithBlock({ (isSuccesful : Bool, error :NSError?) -> Void in
                
                if error == nil {
                    
                    //가입시키기
                    
                    print(isSuccesful)
                    self.performSegueWithIdentifier("resisterToHome", sender: self)
                    
                    
                    
                }else {
                    //에러 경고창 띄우기
                    
                    print(error)
                    print("레지스터 : 가입프로세스 에러")
                }
                
            })
            
        }
        

        

        
    }

}

