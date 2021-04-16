//
//  UIViewController extension.swift
//  Grand Candy
//
//  Created by MacBook Pro on 4/10/20.
//  Copyright © 2020 Ruben Nahatakyan. All rights reserved.
//

import UIKit

extension UIViewController {
    // MARK: - Change root controller
    func changeRootController(to controller: UIViewController, animation: Bool = true, animationDuration: Double = 0.5) {
        guard let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate else { return }
        sceneDelegate.changeRootController(to: controller, animation: animation, animationDuration: animationDuration)
    }

    // MARK: - Show error
    func showError(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
