//
//  ViewController.swift
//  Login
//
//  Created by Vishal Shah on 1/31/16.
//  Copyright © 2016 Vishal Shah. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate {

    @IBOutlet var signInButton: GIDSignInButton!    
    @IBOutlet var fbLoginButton: FBSDKLoginButton!
    
    @IBOutlet var SignUp: UIButton!
    @IBOutlet var forgotPasswordButton: UIButton!
    
    @IBAction func signupRegister(sender: AnyObject) {
    }
    
    
    @IBAction func forgotPassword(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //facebook
        fbLoginButton.delegate = self
        fbLoginButton.readPermissions = ["public_profile", "email", "user_friends"]
        
        
        //google 
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Uncomment to automatically sign in the user.
        if(GIDSignIn.sharedInstance().hasAuthInKeychain()){print("sign in silently")
            GIDSignIn.sharedInstance().signInSilently()
        }
    }
    
    override func viewWillAppear(animated: Bool) {print("In viewWillAppear")
        super.viewWillAppear(animated)
        
        //this is so if you're already logged in, it will take you directly to the protected page, instead of launching the login page each time upon launch
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            protectedPageNavigation()
        }
    }
    //facebook login
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if(error != nil){
            print(error.localizedDescription)
            return
        }
        
        if FBSDKAccessToken.currentAccessToken() != nil {
           
            print("Login complete")
            
           
            //let token:FBSDKAccessToken = result.token
            print("token is: \(FBSDKAccessToken.currentAccessToken().tokenString)")
            print("user is: \(FBSDKAccessToken.currentAccessToken().userID)")
            
                
            //now take user to protected page.
            protectedPageNavigation()
        }
    }
    //facebook
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User logged out")
    }
    
    
    func protectedPageNavigation() {
        let protectedPage = self.storyboard?.instantiateViewControllerWithIdentifier("ProtectedPageViewController") as! ProtectedPageViewController
        
        let protectedPageNav = UINavigationController(rootViewController: protectedPage)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = protectedPageNav
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    /*func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        //myActivityIndicator.stopAnimating()
    }*/
    
    // Present a view that prompts the user to sign in with Google
    func signIn(signIn: GIDSignIn!,
        presentViewController viewController: UIViewController!) {
            self.presentViewController(viewController, animated: true, completion: nil)
            
        print("***Sign in presented*****")
    }
    
    // Dismiss/Cancel the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!,
        dismissViewController viewController: UIViewController!) {
            self.dismissViewControllerAnimated(true, completion: nil)
            
        print("Sign in dismissed")
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

}

