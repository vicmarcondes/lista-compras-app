//
//  ProductsTableViewCell.swift
//  ListaComprasApp
//
//  Created by admin on 27/01/24.
//

import UIKit

protocol ProductsTableViewCellProtocol: AnyObject {
    func tappedPlusQuantityButton(indexPath: IndexPath)
    func tappedMinusQuantityButton(indexPath: IndexPath)
}

class ProductsTableViewCell: UITableViewCell {
    static let identifier = "ProductsTableViewCell"
    
    private weak var delegate: ProductsTableViewCellProtocol?
    
    public func delegate(delegate: ProductsTableViewCellProtocol) {
        self.delegate = delegate
    }
    
    private var indexPath: IndexPath?
    
    lazy var productLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.text = "Banana"
        return label
    }()
    
    lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.text = "4"
        return label
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "plus.circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(tappedPlusQuantityButton), for: .touchUpInside)
        return button
    }()
    
    lazy var minusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "minus.circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(tappedMinusQuantityButton), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(productLabel)
        addSubview(quantityLabel)
        addSubview(plusButton)
        addSubview(minusButton)
        bringSubviewToFront(plusButton)
        bringSubviewToFront(minusButton)
        // Initialization code
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setupCell(product: Product, indexPath: IndexPath) {
        self.indexPath = indexPath
        
        productLabel.text = product.name
        quantityLabel.text =  String(product.quantity)
    }
    
    @objc func tappedPlusQuantityButton() {
        delegate?.tappedPlusQuantityButton(indexPath: self.indexPath!)
    }
    
    @objc func tappedMinusQuantityButton() {
        delegate?.tappedMinusQuantityButton(indexPath: self.indexPath!)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            productLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            productLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            productLabel.trailingAnchor.constraint(equalTo: minusButton.leadingAnchor, constant: -16),
            
            quantityLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            quantityLabel.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -8),
            
            plusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 24),
            plusButton.heightAnchor.constraint(equalToConstant: 24),
            plusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            minusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            minusButton.widthAnchor.constraint(equalToConstant: 24),
            minusButton.heightAnchor.constraint(equalToConstant: 24),
            minusButton.trailingAnchor.constraint(equalTo: quantityLabel.leadingAnchor, constant: -8),
        ])
    }


    

}