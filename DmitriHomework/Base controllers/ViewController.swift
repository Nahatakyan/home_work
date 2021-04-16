//
//  ViewController.swift
//  DmitriHomework
//
//  Created by Ruben Nahatakyan on 16.04.21.
//

import RxSwift
import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    public let disposeBag = DisposeBag()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background

        setupUI()
        setupBinding()
        startup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameChangedNotification(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
}

// MARK: Startup
extension ViewController {
    @objc func setupUI() {}
    @objc func startup() {}
    @objc func setupBinding() {}

    @objc func keyboardFrameChanged(frame: CGRect, duration: Double) {}
}

// MARK: Actions
extension ViewController {
    // MARK: Tap to hide
    @discardableResult
    public final func addTapToHideKeyboardAction(view: UIView, delegate: UIGestureRecognizerDelegate? = nil) -> UITapGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardAction(_:)))
        view.addGestureRecognizer(tap)
        tap.delegate = delegate
        return tap
    }

    // MARK: Keyboard
    @objc private func keyboardFrameChangedNotification(_ sender: Notification) {
        guard let userInfo = sender.userInfo, let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect, let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        keyboardFrameChanged(frame: keyboardFrame, duration: duration)
    }

    @objc final func hideKeyboardAction(_ sender: UITapGestureRecognizer? = nil) {
        view.endEditing(true)
    }
}

// MARK: - Gesture delegate
extension ViewController: UIGestureRecognizerDelegate {}
