//
//  AuthResponse.swift
//  OnTheMap
//
//  Created by Artem Osipov on 07/04/2020.
//  Copyright © 2020 Artem Osipov. All rights reserved.
//

import Foundation


struct AuthResponse: Codable {
    let account: Account
    let session: Session
}

struct Account: Codable {
    let registered: Bool
    let key: String
}

struct Session: Codable {
    let id: String
    let expiration: String
}

struct ErrorResponse: Codable {
    let status: Int
    let error: String
}

/*
 {"account":{"registered":true,"key":"6288949478"},"session":{"id":"9632048069S6c6e5cf47bd098a8224ad63a920b277d","expiration":"2020-04-08T13:27:24.224950Z"}}
 
 */
