//
//  ListsScreenCell.swift
//  ListaComprasApp
//
//  Created by admin on 08/02/24.
//

import UIKit

class ListsTableViewCell: UITableViewCell {
    static let identifier = "ListsTableViewCell"
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let productsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(nameLabel)
        addSubview(productsLabel)
        configConstraints()
        configCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupCell(list: List) {
        nameLabel.text = list.name
        
        if let products = list.products as? Set<Product> {
            let productsArray = Array(products)
            
            let productsNames = productsArray.map { product in
                product.name ?? "Produto"
            }
            
            productsLabel.text = productsNames.joined(separator: ", ")
        }
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -12),

            productsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            productsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            productsLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 12),
        ])
    }
    
    private func configCell() {
        self.backgroundColor = .appBlue
//        self.layer.borderColor = UIColor.white.cgColor
//        self.layer.borderWidth = 0.2
    }

}
