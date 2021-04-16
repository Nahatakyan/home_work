//
//  PaymentsViewModel.swift
//  DmitriHomework
//
//  Created by Ruben Nahatakyan on 16.04.21.
//

import Foundation
import NetworkManager
import RxCocoa
import RxSwift

class PaymentsViewModel: NSObject {
    // MARK: - Observers
    private let modelPayments: BehaviorRelay<[PaymentsListResponseModel]> = BehaviorRelay(value: [])
    public var payments: Observable<[PaymentsListResponseModel]> {
        return modelPayments.asObservable()
    }

    private let modelIsLoading: PublishRelay<Bool> = PublishRelay()
    public var isLoading: Observable<Bool> {
        return modelIsLoading.asObservable()
    }

    private let modelErrorDetected: PublishRelay<String> = PublishRelay()
    public var errorDetected: Observable<String> {
        return modelErrorDetected.asObservable()
    }
}

// MARK: - Public methods
extension PaymentsViewModel {
    func getPayments() {
        guard let model = PaymentsListRequestModel() else { return }
        modelIsLoading.accept(true)

        PaymentsRequestService.list(model: model).request { [weak self] (response: NetworkManagerResult<[PaymentsListResponseModel]>) in
            self?.modelIsLoading.accept(false)
            switch response {
            case .success(let model):
                self?.modelPayments.accept(model)
            case .failure(let error):
                self?.modelErrorDetected.accept(error.message)
            }
        }
    }
}
