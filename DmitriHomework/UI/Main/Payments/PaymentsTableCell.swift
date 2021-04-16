//
//  PaymentsTableCell.swift
//  DmitriHomework
//
//  Created by Ruben Nahatakyan on 16.04.21.
//

import UIKit

class PaymentsTableCell: UITableViewCell {
    // MARK: - Views
    private lazy var cardView: UIView = {
        let view = UIView(frame: .zero)
        view.clipsToBounds = true
        view.layer.cornerRadius = 3
        view.backgroundColor = .contentBackground
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var currencyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .text
        label.font = .boldSystemFont(ofSize: 18)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .text
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .text
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.alpha = 0.5
        label.textColor = .text
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Don't use storyboard")
    }
}

// MARK: - Setup UI
private extension PaymentsTableCell {
    func setupUI() {
        guard cardView.superview == nil else { return }
        
        addCardView()
        addStackView()
        
        stackView.addArrangedSubview(topStackView)
        topStackView.addArrangedSubview(currencyLabel)
        topStackView.addArrangedSubview(amountLabel)
        
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(dateLabel)
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
    }
    
    // MARK: Card view
    func addCardView() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardView)
        
        cardView.pinEdgesToSuperView(top: 8, left: 16, bottom: 8, right: 16)
    }
    
    // MARK: Stack view
    func addStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(stackView)
        
        stackView.pinEdgesToSuperView(top: 8, left: 8, bottom: 8, right: 8)
    }
}

// MARK: - Public methods
extension PaymentsTableCell {
    func setData(_ payment: PaymentsListResponseModel) {
        currencyLabel.text = payment.currency
        descriptionLabel.text = payment.description
        amountLabel.text = payment.amount.stringValue
        
        if let date = payment.created {
            dateLabel.text = date.string()
            if dateLabel.isHidden {
                dateLabel.isHidden = false
            }
        } else if !dateLabel.isHidden {
            dateLabel.isHidden = true
        }
    }
}
