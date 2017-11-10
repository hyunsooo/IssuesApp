//
//  GithubRouter.swift
//  IssuesApp
//
//  Created by hyunsu han on 2017. 11. 4..
//  Copyright © 2017년 hyunsu han. All rights reserved.
//

import Foundation
import Alamofire

enum GitHubRouter {
    case repoIssues(owner: String, repo: String, paramter: Parameters)
}

extension GitHubRouter: URLRequestConvertible {
    
    static let baseUrlString: String = "https://api.github.com"
    
    static let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        configuration.httpCookieStorage = HTTPCookieStorage.shared
        configuration.urlCache = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        let manager = Alamofire.SessionManager(configuration: configuration)
        return manager
    }()
    
    
    
    var method: HTTPMethod {
        switch self {
        case .repoIssues:
            return .get
        }
    }
    var path: String {
        switch self {
        case let .repoIssues(owner, repo, _):
            return "/repos/\(owner)/\(repo)/issues"
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        let url = try GitHubRouter.baseUrlString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        if let token = GlobalState.instance.token, !token.isEmpty {
            urlRequest.setValue("token \(token)", forHTTPHeaderField: "Authorization")
        }
        switch self {
        case let .repoIssues(_ , _, paramter):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: paramter)
            return urlRequest
        }
        
    }
    
    
}
