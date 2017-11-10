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
    
}

