//
//  ViewController.swift
//  IssuesApp
//
//  Created by hyunsu han on 2017. 10. 28..
//  Copyright © 2017년 hyunsu han. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    static var viewControleer: LoginViewController {
        
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return LoginViewController() }
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginToGithubButtonTapped() {
        App.api.getToken { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
}

