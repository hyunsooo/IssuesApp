//
//  ReposViewController.swift
//  IssuesApp
//
//  Created by hyunsu han on 2017. 11. 4..
//  Copyright © 2017년 hyunsu han. All rights reserved.
//

import UIKit

class ReposViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    let dataSource: [(owner: String, repo: String)] = GlobalState.instance.repos
    var selectedRepo: (owner: String, repo: String)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension ReposViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath)
        let data = dataSource[indexPath.row]
        cell.textLabel?.text = "/\(data.owner)/\(data.repo)"
        return cell
    }
}

extension ReposViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = dataSource[indexPath.row]
        selectedRepo = data
        self.performSegue(withIdentifier: "unwindToIssue", sender: self)    // sender를 self로 repo를 자기자신도 받아야 하기 때문이다.
    }

}


















