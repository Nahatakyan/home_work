//
//  PaymentsListRequestModel.swift
//  DmitriHomework
//
//  Created by Ruben Nahatakyan on 16.04.21.
//

import Foundation

class PaymentsListRequestModel: Codable {
    let token: String

    init?() {
        guard let token = KeychainManager.shared.get(name: .token) else { return nil }
        self.token = token
    }
}
