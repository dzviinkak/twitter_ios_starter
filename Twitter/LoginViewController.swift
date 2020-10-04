//
//  LoginViewController.swift
//  Twitter
//
//  Created by Dzvinka Koman on 10/4/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // check if defaults is set to userloggedin -- means that user is logged in & no need to ask for credentials once again
        // if true, performSegue with identifier "loginToHome"
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true {self.performSegue(withIdentifier: "loginToHome", sender: self)
    }
        
    }
    @IBAction func onLoginButton(_ sender: Any) {
        let myUrl = "https://api.twitter.com/oauth/request_token"
        // sends the user the the twitter api
        // when user presses login button
        // uses segue logintohome, moves to the navigation bar
        // if not logged in, shows an error message
        // if logged in, set userdefaults to boolvalue true and set the key for that to "userLoggedin"
        // in that case, in viewdidAppear, you can check wehther this userdefault is set to true and in that case, avoid asking for credentials (and send user to homepage directly
        TwitterAPICaller.client?.login(url: myUrl, success: { UserDefaults.standard.set(true, forKey: "userLoggedIn")
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: {(Error) in print("Could not log in!")})
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
