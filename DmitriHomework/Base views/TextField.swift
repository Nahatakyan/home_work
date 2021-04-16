//
//  TextField.swift
//  DmitriHomework
//
//  Created by Ruben Nahatakyan on 16.04.21.
//

import UIKit

class TextField: UITextField {

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        startup()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("Don't use storyboard")
    }
}

// MARK: - Startup
extension TextField {
    private func startup() {
        textColor = .text
        borderStyle = .roundedRect
        backgroundColor = .contentBackground

        font = .systemFont(ofSize: 16)
    }
}
