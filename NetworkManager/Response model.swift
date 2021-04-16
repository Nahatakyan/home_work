//
//  ResponseModel.swift
//  Grand Candy
//
//  Created by Ruben Nahatakyan on 6/1/20.
//  Copyright © 2020 Ruben Nahatakyan. All rights reserved.
//

import Foundation

class ResponseModel<T: Codable>: Codable {
    let success: Bool
    let response: T?
    let error: ResponseModelError?

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let success = try values.decode(String.self, forKey: .success)

        self.success = success == "true" ? true : false
        if values.allKeys.contains(.response) {
            response = try values.decode(T.self, forKey: .response)
        } else {
            response = nil
        }
        
        if values.allKeys.contains(.error) {
            error = try values.decode(ResponseModelError.self, forKey: .error)
        } else {
            error = nil
        }
    }
}

public class ResponseModelError: Codable {
    public var code: Int
    public var message: String
    
    enum CodingKeys: String, CodingKey {
        case code = "error_code"
        case message = "error_msg"
    }
    
}
