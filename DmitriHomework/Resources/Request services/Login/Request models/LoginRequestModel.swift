//
//  LoginRequestModel.swift
//  DmitriHomework
//
//  Created by Ruben Nahatakyan on 16.04.21.
//

import Foundation

class LoginRequestModel: Codable {
    let login: String
    let password: String

    init(login: String, password: String) {
        self.login = login
        self.password = password
    }
}
