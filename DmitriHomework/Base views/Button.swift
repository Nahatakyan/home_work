//
//  Button.swift
//  DmitriHomework
//
//  Created by Ruben Nahatakyan on 16.04.21.
//

import UIKit

class Button: UIButton {
    // MARK: - Properties
    override var isEnabled: Bool {
        willSet {
            alpha = newValue ? 1 : 0.5
        }
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        startup()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("Don't use storyboard")
    }
}

// MARK: - Startup
private extension Button {
    func startup() {
        setTitleColor(.text, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16)
    }
}
