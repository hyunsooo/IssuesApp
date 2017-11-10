//
//  API.swift
//  IssuesApp
//
//  Created by hyunsu han on 2017. 10. 28..
//  Copyright © 2017년 hyunsu han. All rights reserved.
//

import Foundation

protocol API {
    func getToken(handler: @escaping (() -> Void))
    func getRefreshToken(handler: @escaping (() -> Void))
    func repoIssues(owner: String, repo: String, page: Int, handler: @escaping IssuesResponseHandler)
}


