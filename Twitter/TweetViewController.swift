//
//  TweetViewController.swift
//  Twitter
//
//  Created by Dzvinka Koman on 10/16/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tweetText.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {
        // nill in completion, because when cancel prseed notihing should happen except for dismiss
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        // ! means not
        if (!tweetText.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: tweetText.text, success: {self.dismiss(animated: true, completion: nil)}, failure: { (error) in print("Error posting tweet \(error)")}) // \(error) pastes the error object
            
        } else {
            self.dismiss(animated: true, completion: nil) 
        }
    }
    
    @IBOutlet weak var tweetText: UITextView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
