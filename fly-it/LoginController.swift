//
//  LoginController.swift
//  fly-it
//
//  Created by Ryan on 3/25/19.
//  Copyright © 2019 Ryan. All rights reserved.
//

// import Foundation

//
//  ViewController.swift
//  XcodeLoginExample
//
//  Created by Belal Khan on 29/05/17.
//  Copyright © 2017 Belal Khan. All rights reserved.
//

import UIKit
import Alamofire

class LoginController: UIViewController {
    
    //The login script url make sure to write the ip instead of localhost
    //you can get the ip using ifconfig command in terminal
    let URL_USER_LOGIN = "https://fly-it.herokuapp.com/polls/login"
    
    //the defaultvalues to store user data
//    let defaultValues = UserDefaults.standard
    let defaultValues = NSUserDefaults.standardUserDefaults()
    
    //the connected views
    //don't copy instead connect the views using assistant editor
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    //the button action function
    @IBAction func buttonLogin(_sender: UIButton) {
        
        //getting the username and password
//        let parameters: Parameters=[
//        "email":textFieldEmail.text!,
//        "password":textFieldPassword.text!
//        ]
        
        //making a post request
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: ["email":textFieldEmail.text,
            "password": textFieldPassword.text], encoding: JSONEncoder(options: [])).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    
                    //if there is no error
                    if((jsonData.value(forKey: "auth") as! Bool)){
                        
                        //getting the user from response
                        let token = jsonData.value(forKey: "token") as! String
                        
                        //saving user values to defaults
                        self.defaultValues.set(token, forKey: "token")
                        
                        //switching the screen
                        let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeController") as! HomeController
                        self.navigationController?.pushViewController(profileViewController, animated: true)
                        
                        self.dismiss(animated: false, completion: nil)
                    }else{
                        //error message in case of invalid credential
                        self.labelMessage.text = "Invalid email or password"
                    }
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //hiding the navigation button
//        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
//        navigationItem.leftBarButtonItem = backButton
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //if user is already logged in switching to profile screen
//        if defaultValues.string(forKey: "token") != nil{
//            let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeController") as! HomeController
//            self.navigationController?.pushViewController(profileViewController, animated: true)
//            
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}