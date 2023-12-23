//
//  HomeScreen.swift
//  ListaComprasApp
//
//  Created by admin on 22/12/23.
//

import UIKit

class HomeScreen: UIView {
    
    lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.standard()
        image.image = UIImage(systemName: "cart")
        image.contentMode = .scaleAspectFill
        image.tintColor = .white
        return image
    }()
    
    lazy var getListsButton: UIButton = {
        let button = UIButton()
        button.setButton(title: "Listas", backgroundColor: .white, fontColor: .appBlue, fontSize: 16)
        button.layer.borderColor = UIColor.appBlue.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        return button
    }()
    
    lazy var newListButton: UIButton = {
        let button = UIButton()
        button.setButton(title: "Nova lista", backgroundColor: .white, fontColor: .appBlue, fontSize: 16)
        button.layer.borderColor = UIColor.appBlue.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(logoImage)
        addSubview(getListsButton)
        addSubview(newListButton)
        setupConstrainnts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstrainnts() {
        NSLayoutConstraint.activate([
            logoImage.heightAnchor.constraint(equalToConstant: 120),
            logoImage.widthAnchor.constraint(equalToConstant: 120),
            logoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            getListsButton.heightAnchor.constraint(equalToConstant: 45),
            getListsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            getListsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            getListsButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -32),
            
            newListButton.heightAnchor.constraint(equalTo: getListsButton.heightAnchor),
            newListButton.trailingAnchor.constraint(equalTo: getListsButton.trailingAnchor),
            newListButton.leadingAnchor.constraint(equalTo: getListsButton.leadingAnchor),
            newListButton.bottomAnchor.constraint(equalTo: getListsButton.topAnchor, constant: -16),
        ])
    }
}
