//
//  TweetCell.swift
//  Twitter
//
//  Created by Dzvinka Koman on 10/4/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favouriteButton: UIButton!
    
    var favourited:Bool = false
    var tweetId:Int = -1
    var retweeted:Bool = false
    
    
    func setFavourite( isFavourited:Bool){
        favourited = isFavourited
        if (favourited) {
            favouriteButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else {
        favouriteButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
    }
    }
    
    func setRetweeted(_ isRetweeted: Bool) {
        if (isRetweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {self.setRetweeted(true)}, failure: {(error) in print("Error in retweeting : \(error)")})
    }
    @IBAction func favourite(_ sender: Any) {
        let tobeFavourited = !favourited
        if (tobeFavourited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {self.setFavourite(isFavourited: true)}, failure: { (error) in print("Favourite did not succeed: \(error)")})
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId , success: {self.setFavourite(isFavourited: false)}, failure: {(error) in print("Unfavourite did not succeed: \(error)")})
        }
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

 }
