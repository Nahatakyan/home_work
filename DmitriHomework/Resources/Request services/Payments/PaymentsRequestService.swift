//
//  PaymentsRequestService.swift
//  DmitriHomework
//
//  Created by Ruben Nahatakyan on 16.04.21.
//

import Foundation
import NetworkManager

enum PaymentsRequestService {
    case list(model: PaymentsListRequestModel)
}

extension PaymentsRequestService: RequestService {
    var path: String {
        switch self {
        case .list:
            return "payments"
        }
    }

    var method: RequestMethod {
        switch self {
        case .list:
            return .get
        }
    }

    var params: NSDictionary? {
        switch self {
        case .list(let model):
            return model.dictionary
        }
    }

    var encoding: RequestEncodingTypeEnum {
        return .query
    }

    var headers: [String: String] {
        return [
            "app-key": "12345",
            "v": "1"
        ]
    }

    func errorResponse(_ error: NetworkManagerError) {}
}
