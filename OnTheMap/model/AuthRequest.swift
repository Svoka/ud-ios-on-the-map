//
//  AuthRequest.swift
//  OnTheMap
//
//  Created by Artem Osipov on 07/04/2020.
//  Copyright © 2020 Artem Osipov. All rights reserved.
//

import Foundation

struct AuthRequest: Encodable {
    let udacity: Credentials
}

struct Credentials: Encodable {
    let username: String
    let password: String
}
