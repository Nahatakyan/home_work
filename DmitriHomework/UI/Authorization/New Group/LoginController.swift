//
//  LoginController.swift
//  DmitriHomework
//
//  Created by Ruben Nahatakyan on 16.04.21.
//

import MBProgressHUD
import RxBiBinding
import UIKit

class LoginController: ViewController {
    // MARK: - Views
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .always
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var loginTextField: TextField = {
        let textField = TextField(frame: .zero)
        textField.delegate = self
        textField.placeholder = "Login"
        textField.returnKeyType = .next
        textField.keyboardType = .default
        textField.textContentType = .username
        return textField
    }()

    private lazy var passwordTextField: TextField = {
        let textField = TextField(frame: .zero)
        textField.delegate = self
        textField.returnKeyType = .done
        textField.keyboardType = .default
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.textContentType = .password
        return textField
    }()

    private lazy var loginButton: Button = {
        let button = Button(frame: .zero)
        button.layer.cornerRadius = 3
        button.backgroundColor = .systemBlue
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        button.addTarget(self, action: #selector(loginButtonAction(_:)), for: .touchUpInside)
        return button
    }()

    // MARK: - Constrains
    private var conntentViewHeightConstraint: NSLayoutConstraint!

    // MARK: - Properties
    private let viewModel = LoginViewModel()
}

// MARK: - Setup UI
extension LoginController {
    override func setupUI() {
        addScrollView()
        addContentView()
        addStackView()

        addLoginTextField()
        addPasswordTextField()
        addLoginButton()
    }

    // MARK: Scroll view
    private func addScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        scrollView.pinEdgesToSuperView()
    }

    // MARK: Content view
    private func addContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        contentView.pinEdgesToSuperView()
        conntentViewHeightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.heightAnchor)
        conntentViewHeightConstraint.priority = UILayoutPriority(rawValue: 999)
        NSLayoutConstraint.activate([
            conntentViewHeightConstraint,
            contentView.widthAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.widthAnchor)
        ])
    }

    // MARK: Stack view
    private func addStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)

        stackView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 24).isActive = true
        stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6).isActive = true
    }

    // MARK: Login text field
    private func addLoginTextField() {
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(loginTextField)

        NSLayoutConstraint.activate([
            loginTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }

    // MARK: Password text field
    private func addPasswordTextField() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(passwordTextField)

        NSLayoutConstraint.activate([
            passwordTextField.widthAnchor.constraint(equalTo: loginTextField.widthAnchor)
        ])
    }

    // MARK: Login button
    private func addLoginButton() {
        stackView.addArrangedSubview(loginButton)
    }
}

// MARK: - Startup
extension LoginController {
    override func startup() {
        addTapToHideKeyboardAction(view: view, delegate: self)
    }
}

// MARK: - Setup binding
extension LoginController {
    override func setupBinding() {
        (loginTextField.rx.text.orEmpty <-> viewModel.login).disposed(by: disposeBag)
        (passwordTextField.rx.text.orEmpty <-> viewModel.password).disposed(by: disposeBag)

        viewModel.canLogin.bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)

        viewModel.isLoading.bind { [weak self] loading in
            guard let `self` = self else { return }
            if loading {
                MBProgressHUD.showAdded(to: self.view, animated: true)
            } else {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }.disposed(by: disposeBag)

        viewModel.errorDetected.bind { [weak self] message in
            self?.showError(title: "Error", message: message)
        }.disposed(by: disposeBag)

        viewModel.logedIn.bind { [weak self] _ in
            self?.changeRootController(to: PaymentsController())
        }.disposed(by: disposeBag)
    }
}

// MARK: - Gesture recognizer delegate
extension LoginController {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return UIApplication.shared.isKeyboardPresented
    }
}

// MARK: - Text field delegate
extension LoginController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case loginTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            loginButtonAction(loginButton)
        default:
            break
        }

        return true
    }
}

// MARK: - Actions
extension LoginController {
    // MARK: Keyboard frame changed
    override func keyboardFrameChanged(frame: CGRect, duration: Double) {
        UIView.animate(withDuration: duration) {
            let constant = min(frame.minY - self.scrollView.frame.maxY, 0)
            self.scrollView.contentInset.bottom = abs(constant)
            self.conntentViewHeightConstraint.constant = constant
            self.view.layoutIfNeeded()
        }
    }

    // MARK: Login button action
    @objc private func loginButtonAction(_ sender: Button) {
        hideKeyboardAction()
        guard sender.isEnabled else { return }
        viewModel.loginAction()
    }
}
