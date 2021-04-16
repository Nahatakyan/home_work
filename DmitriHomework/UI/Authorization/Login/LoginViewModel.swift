//
//  LoginViewModel.swift
//  DmitriHomework
//
//  Created by Ruben Nahatakyan on 16.04.21.
//

import NetworkManager
import RxCocoa
import RxSwift
import UIKit

class LoginViewModel: NSObject {
    // MARK: - Observers
    public let login: BehaviorRelay<String> = BehaviorRelay(value: "")
    public let password: BehaviorRelay<String> = BehaviorRelay(value: "")

    private let modelIsLoading: PublishRelay<Bool> = PublishRelay()
    public var isLoading: Observable<Bool> {
        return modelIsLoading.asObservable()
    }

    private let modelErrorDetected: PublishRelay<String> = PublishRelay()
    public var errorDetected: Observable<String> {
        return modelErrorDetected.asObservable()
    }
    
    private let modelLogedIn: PublishRelay<Bool> = PublishRelay()
    public var logedIn: Observable<Bool> {
        return modelLogedIn.asObservable()
    }

    public var canLogin: Observable<Bool> {
        return Observable.combineLatest(login.asObservable(), password.asObservable()) { login, password in
            return !login.isEmpty && !password.isEmpty
        }
    }
}

// MARK: - Public methods
extension LoginViewModel {
    func loginAction() {
        modelIsLoading.accept(true)

        let model = LoginRequestModel(login: login.value, password: password.value)
        AuthorizationRequestService.login(model: model).formDataRequest { [weak self] (response: NetworkManagerResult<LoginResponseModel>) in
            self?.modelIsLoading.accept(false)
            switch response {
            case .success(let model):
                KeychainManager.shared.save(value: model.token, to: .token)
                self?.modelLogedIn.accept(true)
            case .failure(let error):
                self?.modelErrorDetected.accept(error.message)
            }
        }
    }
}
