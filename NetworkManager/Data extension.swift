//
//  Data extension.swift
//  MyUni
//
//  Created by Ruben Nahatakyan on 10/17/19.
//  Copyright © 2019 Ruben Nahatakyan. All rights reserved.
//

import UIKit

public extension Data {
    var text: NSString {
        return NSString(data: self, encoding: String.Encoding.utf8.rawValue) ?? "Can't get text from data"
    }
}
