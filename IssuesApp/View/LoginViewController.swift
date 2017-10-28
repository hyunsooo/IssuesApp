//
//  ViewController.swift
//  IssuesApp
//
//  Created by hyunsu han on 2017. 10. 28..
//  Copyright © 2017년 hyunsu han. All rights reserved.
//

import UIKit
import OAuthSwift

class LoginViewController: UIViewController {
  
    let oauth: OAuth2Swift = OAuth2Swift(
        consumerKey: "c0183144d80fca2628be",
        consumerSecret: "f2118f7577c167b1d04417f1ebae655fcae19b4b",
        authorizeUrl: "https://github.com/login/oauth/authorize",
        accessTokenUrl: "https://github.com/login/oauth/access_token",
        responseType: "code"
    )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginToGithubButtonTapped() {
        oauth.authorize(
            withCallbackURL: "issuesapp://oauth-callback/github",
            scope: "user,repo",
            state: "state",
            success: { (credential, _, _) in
                let token = credential.oauthToken
                print("token : \(token)")
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
}

