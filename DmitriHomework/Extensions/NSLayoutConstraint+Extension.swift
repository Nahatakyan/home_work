//
//  NSLayoutConstraint+Extension.swift
//  DmitriHomework
//
//  Created by Ruben Nahatakyan on 09.03.21.
//  Copyright © 2021 M&M MEDIA, INC. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    // MARK: With priority
    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }

    func withPriority(_ priority: Float) -> NSLayoutConstraint {
        self.priority = UILayoutPriority(priority)
        return self
    }
}
