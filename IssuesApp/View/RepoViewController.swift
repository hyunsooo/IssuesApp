//
//  RepoViewController.swift
//  IssuesApp
//
//  Created by hyunsu han on 2017. 11. 4..
//  Copyright © 2017년 hyunsu han. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController {
    
    @IBOutlet var ownerTextField: UITextField!
    @IBOutlet var repoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ownerTextField.text = GlobalState.instance.owner
        repoTextField.text = GlobalState.instance.repo
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func enterButtonTapped(_ sender: Any) {
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EnterRepoSegue" {
            guard let owner = ownerTextField.text, let repo = repoTextField.text else { return }
            
            GlobalState.instance.owner = owner
            GlobalState.instance.repo = repo
            GlobalState.instance.addRepo(owner: owner, repo: repo)
            
        }
    }
    
    // 해당 Segue를 실행 여부를 결정하는 함수
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "EnterRepoSegue" {
            guard let owner = ownerTextField.text, let repo = repoTextField.text else { return false }
            return !(owner.isEmpty || repo.isEmpty)
        }
        return true
    }
    
}


extension RepoViewController {
    @IBAction func logoutButtonTapped(_ sender: Any) {
        GlobalState.instance.token = ""
        let loginViewController = LoginViewController.viewControleer
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) { [weak self] in
            self?.present(loginViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func unwindFromRepos(_ segue: UIStoryboardSegue) {
        guard let reposViewController = segue.source as? ReposViewController else { return }
        guard let (owner, repo) = reposViewController.selectedRepo else { return }
        
        ownerTextField.text = owner
        repoTextField.text = repo
        
        DispatchQueue.main.async { [weak self] in
            self?.performSegue(withIdentifier: "EnterRepoSegue", sender: nil)
        }
    }
}


