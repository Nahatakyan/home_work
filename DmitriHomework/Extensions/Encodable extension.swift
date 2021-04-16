//
//  Encodable extension.swift
//  Grand Candy
//
//  Created by Ruben Nahatakyan on 9/14/19.
//  Copyright © 2019 Ruben Nahatakyan. All rights reserved.
//

import Foundation

extension Encodable {
    var dictionary: NSDictionary? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: [.allowFragments, .mutableLeaves])).flatMap { $0 as? NSDictionary }
    }

    var text: NSString {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(self) else { return "" }
        return data.text
    }
}
