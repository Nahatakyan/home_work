//
//  UIApplication extension.swift
//  Grand Candy
//
//  Created by Ruben Nahatakyan on 6/4/20.
//  Copyright © 2020 Ruben Nahatakyan. All rights reserved.
//

import UIKit

extension UIApplication {
    var isKeyboardPresented: Bool {
        if let keyboardWindowClass = NSClassFromString("UIRemoteKeyboardWindow"), self.windows.contains(where: { $0.isKind(of: keyboardWindowClass) }) {
            return true
        }
        return false
    }
}
