//
//  AuthorizationRequestService.swift
//  DmitriHomework
//
//  Created by Ruben Nahatakyan on 16.04.21.
//

import Foundation
import NetworkManager

enum AuthorizationRequestService {
    case login(model: LoginRequestModel)
}

extension AuthorizationRequestService: RequestService {
    var path: String {
        switch self {
        case .login:
            return "login"
        }
    }

    var method: RequestMethod {
        switch self {
        case .login:
            return .post
        }
    }

    var params: NSDictionary? {
        switch self {
        case .login(let model):
            return model.dictionary
        }
    }

    var encoding: RequestEncodingTypeEnum {
        return .default
    }

    var headers: [String: String] {
        return [
            "app-key": "12345",
            "v": "1"
        ]
    }

    func errorResponse(_ error: NetworkManagerError) {}
}
