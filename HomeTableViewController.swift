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
    
    // gets called once
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets()
        // implements pull to refresh
        // #selector tells which function to call when myRefreshControll is triggered
        // first param says that the target of action is the same exact screen
        myRefreshControll.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        // tells which refreshcontrol to use
        tableView.refreshControl = myRefreshControll
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 150

    }
    
    override func viewDidAppear(_ animated: Bool) {
        // super class = view controller
        super.viewDidAppear(animated)
        loadTweets()
    }
    //calls API
    @objc func loadTweets(){
        
        numberOfTweets = 20
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        // saves the number of tweets to retrieve from website
        let myParams = ["count": numberOfTweets]
        // pull the tweets
        // call the API and dictionaries (=tweets)
        // if success adds tweets to dictionary
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
            // stops refreshing from happening infinitely
            self.myRefreshControll.endRefreshing()
        }, failure: { (Error) in print("Could not retrieve tweets")
        })
    }
    
    // implementation of infinite scrolling
    func loadMoreTweets(){
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberOfTweets = numberOfTweets + 20
        let myParams = ["count":numberOfTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
        }, failure: { (Error) in print("Could not retrieve tweets")
        })
    }
    // when user gets to the end of the page, load more tweets
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count{
            loadMoreTweets()
        }
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
        //take this away
        cell.tweetContent.text = tweetArray[indexPath.row]["text"] as! String
        // set up the image
        // uses key from user dictionary
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        // sets up the image
        if let imageData = data {
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
        cell.setFavourite(isFavourited: tweetArray[indexPath.row]["favourited"] as! Bool)
        cell.tweetId = tweetArray[indexPath.row]["id"] as! Int
        cell.setRetweeted(tweetArray[indexPath.row]["retweeted"] as! Bool)
        
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
