//
//  ProductsTableViewCell.swift
//  ListaComprasApp
//
//  Created by admin on 27/01/24.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {
    static let identifier = "ProductsTableViewCell"
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(productLabel)
        addSubview(quantityLabel)
        // Initialization code
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setupCell(product: Product) {
        productLabel.text = product.name
        quantityLabel.text =  String(product.quantity)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            productLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            productLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            quantityLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            quantityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }


    

}
