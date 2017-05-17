//
//  ViewController.swift
//  Candidates Manager
//
//  Created by Bassem Abbas on 5/15/17.
//  Copyright © 2017 Bassem Abbas. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController
    
    
{
    
    @IBOutlet weak var rememberSwitch: UISwitch!
    @IBOutlet weak var emailTextFieled: UITextField!
    @IBOutlet weak var passwordTextFieled: UITextField!
    
    
    
    @IBAction func LoginAction(_ sender: Any) {
        
       
        if (!(self.emailTextFieled.text?.isEmpty)! && !(self.passwordTextFieled.text?.isEmpty)!) {
            
            
            self.loginProcess();
            
        }else{
            
            let alert = UIAlertController(title: "Alert", message: "please fill all fieled", preferredStyle: UIAlertControllerStyle.alert);
        let cancel = UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel, handler: { (cancelAction) in
            
        
        })
            alert.addAction(cancel);
            self.present(alert, animated: true, completion: nil);
            
            
        }
        
    }
    
    
    func loginProcess(){
        
        if (rememberSwitch.isOn == true) {
            
            //save user
            
            UserDefaults.standard.set(true, forKey: "remember");
            
        }else {
            
            UserDefaults.standard.set(false, forKey: "remember");
            
            
            
        }
        

        APPDELEGATE.presentHome();
        
        
    }
    
    
}
