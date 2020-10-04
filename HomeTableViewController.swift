//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Dzvinka Koman on 10/4/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    @IBAction func onLogout(_ sender: Any) {
        // TwitterAPICaller has correct logout instructions
        TwitterAPICaller.client?.logout()
        // returns user to the login page when user presses logout, animated and does not do anything after returning to the screen
        self.dismiss(animated: true, completion: nil)
        // tells the app that the user has logged out
        // sets default under key "userLpoggedin"(same as in LoginViewController" to false7
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath)
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

 
}
