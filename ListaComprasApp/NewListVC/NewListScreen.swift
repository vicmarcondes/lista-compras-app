//
//  NewListScreen.swift
//  ListaComprasApp
//
//  Created by admin on 04/01/24.
//

import UIKit

class NewListScreen: UIView {

    lazy var nameTextInput: UITextField = {
        let input = UITextField()
        input.create(text: "Nova lista", backgroundColor: .appBlue, textColor: .white)
        input.font = UIFont.boldSystemFont(ofSize: 24)
        input.textAlignment = .center
        return input
    }()
    
    lazy var inputsView: UIView = {
        let view = UIView()
        view.standard()
        return view
    }()
    
    lazy var quantityTextInput: UITextField = {
        let input = UITextField()
        input.create(text: "", backgroundColor: .white, textColor: .black)
        input.addPlaceholder(placeholderText: "Qtd", textColor: .gray)
        input.borderRounded()
        input.setPadding(top: 8, left: 8, bottom: 8, right: 8)
        input.font = UIFont.systemFont(ofSize: 15)
        return input
    }()
    
//    lazy var editIconImageView: UIImageView = {
//        let image = UIImageView()
//        image.standard()
//        image.image = UIImage(systemName: "pencil")
//        image.tintColor = .white
//
//        return image
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(nameTextInput)
        addSubview(quantityTextInput)
        addSubview(inputsView)
        inputsView.addSubview(quantityTextInput)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameTextInput.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            nameTextInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameTextInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameTextInput.heightAnchor.constraint(equalToConstant: 40),
            
            inputsView.topAnchor.constraint(equalTo: nameTextInput.bottomAnchor, constant: 48),
            inputsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            inputsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            inputsView.heightAnchor.constraint(equalToConstant: 32),
            
            quantityTextInput.centerYAnchor.constraint(equalTo: inputsView.centerYAnchor),
            quantityTextInput.heightAnchor.constraint(equalTo: inputsView.heightAnchor),
            quantityTextInput.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 0.3)
//            quantityTextInput.leadingAnchor.constraint(equalTo: inputsView.leadingAnchor, constant: 0),
            
        ])
    }
}
