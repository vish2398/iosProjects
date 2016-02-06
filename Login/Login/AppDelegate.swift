//
//  AppDelegate.swift
//  Login
//
//  Created by Vishal Shah on 1/31/16.
//  Copyright © 2016 Vishal Shah. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate{

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        /*****start google signin initilization***/
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        GIDSignIn.sharedInstance().delegate = self
        /*****end google signin initilization***/
        
        
        //facebook signin initialization
        FBSDKLoginButton.classForCoder() //not sure what this does as it worked before this.
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)

        
        return true
    }
    
    //facebook function
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        
        print("string url is: " + url.absoluteString)
        if(url.absoluteString.containsString("fb")){
                return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
        }else{print("HERE?")
            return GIDSignIn.sharedInstance().handleURL(url, sourceApplication: sourceApplication, annotation: annotation)

        }
    }
    
    
    // when this function is called the user is signed in.
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
        withError error: NSError!) {
            if (error == nil) {
                print("in sign in..sign in worked!!")
                
                //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                
                
                // Perform any operations on signed in user here.
                let userId = user.userID                  // For client-side use only!
                let idToken = user.authentication.idToken // Safe to send to the server
                let name = user.profile.name
                let email = user.profile.email
                
                print("user id is: " + userId)
                print("idToken is: " + idToken)
                print("name is: " + name)
                print("email is: " + email)
                
                //now take the user to protected page
                
                //creates the story board (Main is b/c I have a name of "Main.storyboard"
                let myStoryBoard:UIStoryboard = UIStoryboard(name:"Main",bundle:nil)
                let protectedPage = myStoryBoard.instantiateViewControllerWithIdentifier("ProtectedPageViewController") as! ProtectedPageViewController
                let protectedPageNav = UINavigationController(rootViewController: protectedPage)
                
                self.window?.rootViewController = protectedPageNav
                
            } else {
                print("\(error.localizedDescription)")
            }
    }
    // [END signin_handler]
    
    // [START disconnect_handler]
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
        withError error: NSError!) {
    }
    // [END disconnect_handler]

    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

