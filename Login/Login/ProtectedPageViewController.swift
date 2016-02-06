//
//  ProtectedPageViewController.swift
//  Login
//
//  Created by Vishal Shah on 2/4/16.
//  Copyright © 2016 Vishal Shah. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ProtectedPageViewController: UIViewController, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //google
        GIDSignIn.sharedInstance().uiDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButtonTapped(sender: AnyObject) {
        if FBSDKAccessToken.currentAccessToken() != nil {print("fb signing out")
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
        } else{print("google signing out")
            GIDSignIn.sharedInstance().signOut()
        }
        
        //take user back to main page
        //now take user back to login page
        let loginPage = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        let loginPageNav = UINavigationController(rootViewController: loginPage)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginPageNav
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
