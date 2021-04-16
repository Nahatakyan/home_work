//
//  UIView extension.swift
//  DmitriHomework
//
//  Created by Ruben Nahatakyan on 07.04.21.
//

import UIKit

extension UIView {
    func pinEdgesToSuperView(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: top),
            leftAnchor.constraint(equalTo: superview.leftAnchor, constant: left),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -bottom),
            rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -right)
        ])
    }

    func pinCenterToSuperView(xInset: CGFloat = 0, yInset: CGFloat = 0) {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: xInset),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: yInset)
        ])
    }

    @discardableResult
    func addAspectRatio(ratio: CGFloat = 1, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: self, attribute: .height, multiplier: ratio, constant: 0)
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
}
