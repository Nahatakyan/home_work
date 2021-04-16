//
//  PaymentsController.swift
//  DmitriHomework
//
//  Created by Ruben Nahatakyan on 16.04.21.
//

import RxCocoa
import RxSwift
import UIKit
import MBProgressHUD

class PaymentsController: ViewController {
    // MARK: - Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.contentInsetAdjustmentBehavior = .always
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(PaymentsTableCell.self, forCellReuseIdentifier: PaymentsTableCell.name)
        return tableView
    }()

    // MARK: - Properties
    private let viewModel = PaymentsViewModel()
}

// MARK: - Setup UI
extension PaymentsController {
    override func setupUI() {
        addTableView()
    }

    // MARK: Table view
    private func addTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        tableView.pinEdgesToSuperView()
    }
}

// MARK: - Setup bindings
extension PaymentsController {
    override func setupBinding() {
        viewModel.payments.bind(to: tableView.rx.items(cellIdentifier: PaymentsTableCell.name, cellType: PaymentsTableCell.self)) { _, model, cell in
            cell.setData(model)
        }.disposed(by: disposeBag)

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
    }
}

// MARK: - Setup bindings
extension PaymentsController {
    override func startup() {
        viewModel.getPayments()
    }
}
