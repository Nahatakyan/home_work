//
//  SceneDelegate.swift
//  DmitriHomework
//
//  Created by Ruben Nahatakyan on 16.04.21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
}

// MARK: - Acitons
extension SceneDelegate {
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        changeRootController(to: LoginController(), animation: false)
    }
}

// MARK: - Public methods
@available(iOS 13.0, *)
extension SceneDelegate {
    func changeRootController(to controller: UIViewController, animation: Bool = true, animationDuration: Double = 0.25) {
        window?.clipsToBounds = true
        window?.layer.cornerRadius = 3

        guard animation else {
            window?.rootViewController = controller
            window?.makeKeyAndVisible()
            return
        }

        let overlayView = UIScreen.main.snapshotView(afterScreenUpdates: false)
        controller.view.addSubview(overlayView)
        window?.rootViewController = controller
        window?.makeKeyAndVisible()

        UIView.animate(withDuration: animationDuration, delay: 0, options: .transitionCrossDissolve, animations: {
            overlayView.alpha = 0
        }, completion: { _ in
            overlayView.removeFromSuperview()
        })
    }
}
