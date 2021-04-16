//
//  PaymentsListResponseModel.swift
//  DmitriHomework
//
//  Created by Ruben Nahatakyan on 16.04.21.
//

import Foundation

class PaymentsListResponseModel: Codable {
    let description: String
    let amount: Double
    let currency: String
    let created: Date?

    enum CodingKeys: String, CodingKey {
        case description = "desc"
        case amount
        case currency
        case created
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        description = try values.decode(String.self, forKey: .description)

        if let string = try? values.decode(String.self, forKey: .amount) {
            amount = Double(string) ?? 0
        } else {
            amount = try values.decode(Double.self, forKey: .amount)
        }

        if values.allKeys.contains(.currency) {
            currency = try values.decode(String.self, forKey: .currency)
        } else {
            currency = ""
        }

        let unixTime = try values.decode(Int.self, forKey: .created)
        if unixTime != 0 {
            created = Date(timeIntervalSince1970: TimeInterval(unixTime))
        } else {
            created = nil
        }
    }
}
