//
//  GlobalState.swift
//  IssuesApp
//
//  Created by hyunsu han on 2017. 10. 28..
//  Copyright © 2017년 hyunsu han. All rights reserved.
//

import Foundation

final class GlobalState {
    static let instance = GlobalState()
    
    enum Constants: String {
        case tokenKey
        case refreshTokenKey
        case ownerKey
        case repoKey
        case reposKey
    }
    
    open var token: String? {
        get {
            let token = UserDefaults.standard.string(forKey: Constants.tokenKey.rawValue)
            return token
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.tokenKey.rawValue)
        }
    }
    
    var refreshToken: String? {
        get {
            let refreshToken = UserDefaults.standard.string(forKey: Constants.refreshTokenKey.rawValue)
            return refreshToken
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.refreshTokenKey.rawValue)
        }
    }
    
    var owner: String {
        get {
            let owner = UserDefaults.standard.string(forKey: Constants.ownerKey.rawValue) ?? ""
            return owner
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.ownerKey.rawValue)
        }
    }
    
    var repo: String {
        get {
            let repo = UserDefaults.standard.string(forKey: Constants.repoKey.rawValue) ?? ""
            return repo
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.repoKey.rawValue)
        }
    }
    
    var isLoggedIn: Bool {
        let isEmpty = token?.isEmpty ?? true
        return !isEmpty
    }
    
    var repos: [(owner: String, repo: String)] {
        let repoDicts: [[String: String]] = UserDefaults.standard.array(forKey: Constants.reposKey.rawValue) as? [[String: String]] ?? []
        let repos = repoDicts.map { (repoDict: [String: String]) -> (String, String) in
            let owner = repoDict["owner"] ?? ""
            let repo = repoDict["repo"] ?? ""
            return (owner, repo)
        }
        return repos
    }
    
    func addRepo(owner: String, repo: String) {
        let dict = ["owner": owner, "repo": repo]
        var repos: [[String: String]] = UserDefaults.standard.array(forKey: Constants.reposKey.rawValue) as? [[String: String]] ?? []
        repos.append(dict)
        // 중복 제거 : 집합으로 하면 중복된 원소가 포함되지 않는 원리를 이용한다. : NSSet(array: repos).allObjects 
        UserDefaults.standard.set(NSSet(array: repos).allObjects, forKey: Constants.reposKey.rawValue)
    }
    
}

