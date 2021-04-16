//
//  UIResponder extension.swift
//  DmitriHomework
//
//  Created by Ruben Nahatakyan on 10/22/20.
//  Copyright © 2020 M&M MEDIA, INC. All rights reserved.
//

import UIKit

extension UIResponder {
    class var name: String {
        return String(describing: self)
    }
}
