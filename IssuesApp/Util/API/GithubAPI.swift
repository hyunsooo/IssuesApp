//
//  GithubAPI.swift
//  IssuesApp
//
//  Created by hyunsu han on 2017. 11. 4..
//  Copyright © 2017년 hyunsu han. All rights reserved.
//

import Foundation
import OAuthSwift
import Alamofire
import SwiftyJSON

typealias IssuesResponseHandler = (DataResponse<[Model.Issue]>) -> Void

struct GitHubAPI: API {
    
    let oauth: OAuth2Swift = OAuth2Swift(
        consumerKey: "c0183144d80fca2628be",
        consumerSecret: "f2118f7577c167b1d04417f1ebae655fcae19b4b",
        authorizeUrl: "https://github.com/login/oauth/authorize",
        accessTokenUrl: "https://github.com/login/oauth/access_token",
        responseType: "code"
    )
    
    func getToken(handler: @escaping (() -> Void)) {
        oauth.authorize(
            withCallbackURL: "issuesapp://oauth-callback/github",
            scope: "user,repo",
            state: "state",
            success: { (credential, _, _) in
                let token = credential.oauthToken
                let refreshToken = credential.oauthRefreshToken
                print("GET token : \(token), refreshToken : \(refreshToken)")
                GlobalState.instance.token = token
                GlobalState.instance.refreshToken = refreshToken
                handler()
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
    
    func getRefreshToken(handler: @escaping (() -> Void)) {
        guard let refreshToken = GlobalState.instance.refreshToken else { return }
        
        oauth.renewAccessToken(withRefreshToken: refreshToken, success: { (credential, _, _) in
            let token = credential.oauthToken
            let refreshToken = credential.oauthRefreshToken
            print("RENEW token : \(token), refreshToken : \(refreshToken)")
            GlobalState.instance.token = token
            GlobalState.instance.refreshToken = refreshToken
            handler()
        }, failure: { error in
            print(error.localizedDescription)
        })
        
    }
    
    func repoIssues(owner: String, repo: String, page: Int, handler: @escaping IssuesResponseHandler) {
        let paramters: Parameters = ["page" : page, "state": "all"]
        GitHubRouter.manager.request(GitHubRouter.repoIssues(owner: owner, repo: repo, paramter: paramters)).responseSwiftyJSON { (dataResponse: DataResponse<JSON>) in
            
            let result: DataResponse<[Model.Issue]> = dataResponse.map({ (json: JSON) -> [Model.Issue] in
                return json.arrayValue.map({ (json) -> Model.Issue in
                    return Model.Issue.init(json: json)
                })
            })
            
            handler(result)
        }
        
    }
    
    
}
