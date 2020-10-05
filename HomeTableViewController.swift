//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Dzvinka Koman on 10/4/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    // () mean = "start with an empty one"
    var tweetArray = [NSDictionary]()
    var numberOfTweets: Int!
    let myRefreshControll = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweet()
        // implements pull to refresh
        // #selector tells which function to call when myRefreshControll is triggered
        // first param says that the target of action is the same exact screen
        myRefreshControll.addTarget(self, action: #selector(loadTweet), for: .valueChanged)
        // tells which refreshcontrol to use
        tableView.refreshControl = myRefreshControll

    }
    //calls API
    @objc func loadTweet(){
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        // saves the number of tweets to retrieve from website
        let myParams = ["count": 20]
        // pull the tweets
        // call the API and dictionaries (=tweets)
        // if success adds tweets to dictionary
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            for tweet in tweets {
                self.tweetArray.removeAll()
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
            // stops refreshing from happening infinitely
            self.refreshControl?.endRefreshing()
        }, failure: { (Error) in print("Could not retrieve tweets")
        })
    }
    

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        // saves the dictionary under name user in the API
        let user = tweetArray[indexPath.row ]["user"] as! NSDictionary
        cell.userNameLabel.text = user["name"] as! String
        cell.tweetContent.text = tweetArray[indexPath.row]["text"] as! String
        // set up the image
        // uses key from user dictionary
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        // sets up the image
        if let imageData = data {
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
        return cell
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }

 
}
