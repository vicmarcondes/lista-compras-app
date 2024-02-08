//
//  NewListScreen.swift
//  ListaComprasApp
//
//  Created by admin on 04/01/24.
//

import UIKit

protocol NewListScreenProtocol: AnyObject {
    func tappedAddProduct(name: String, quantity: String)
    func tappedCreateList()
}

class NewListScreen: UIView {
    
    weak var delegate: NewListScreenProtocol?
    
    private var alertControler: Alert?
    
    func delegate(delegate: NewListScreenProtocol) {
        self.delegate = delegate
    }
    
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
        input.borderRounded(5)
        input.keyboardType = .decimalPad
        input.font = UIFont.systemFont(ofSize: 15)
        input.paddingLeft(8)
        input.paddingRight(8)
        return input
    }()
    
    lazy var productTextInput: UITextField = {
        let input = UITextField()
        input.create(text: "", backgroundColor: .white, textColor: .black)
        input.addPlaceholder(placeholderText: "Nome do produto", textColor: .gray)
        input.borderRounded(5)
        input.paddingLeft(8)
        input.paddingRight(8)
        input.font = UIFont.systemFont(ofSize: 15)
        input.becomeFirstResponder()
        return input
    }()
    
    lazy var addProductButton: UIButton = {
        let button = UIButton()
        button.standard()
        button.setBackgroundImage(UIImage(systemName: "plus.circle.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(tappedAddProduct), for: .touchUpInside)
        return button
    }()
    
    lazy var productsTableView: UITableView = {
        let tv = UITableView()
        tv.standard()
        tv.layer.cornerRadius = 15
        tv.register(ProductsTableViewCell.self, forCellReuseIdentifier: ProductsTableViewCell.identifier)
        return tv
    }()

    lazy var createListButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Criar Lista", for: .normal)
        button.setTitleColor(.appBlue, for: .normal)
        button.borderRounded(5)
        button.layer.borderColor = UIColor.appBlue.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(tappedCreateList), for: .touchUpInside)
        return button
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
        inputsView.addSubview(productTextInput)
        inputsView.addSubview(addProductButton)
        addSubview(productsTableView)
        addSubview(createListButton)
    }
    
    public func configTableViewDelegateAndDatasource(delegate: UITableViewDelegate, datasource: UITableViewDataSource) {
        productsTableView.delegate = delegate
        productsTableView.dataSource = datasource
    }
    
    public func configAlertController(controller: UIViewController) {
        alertControler = Alert(controller: controller)
    }
    
    @objc func tappedAddProduct() {
        guard let name = productTextInput.text else { return }
        guard let quantity = quantityTextInput.text else { return }
        
        if quantity.isEmpty || name.isEmpty {
            alertControler?.showAlert(title: "Campos inválidos", message: "Preencha os campos de nome e quantidade.")
            return
        }
        
        delegate?.tappedAddProduct(name: name, quantity: quantity)
        
        productsTableView.reloadData()
    }
    
    @objc func tappedCreateList() {
        delegate?.tappedCreateList()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameTextInput.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            nameTextInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameTextInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameTextInput.heightAnchor.constraint(equalToConstant: 40),
            
            inputsView.topAnchor.constraint(equalTo: nameTextInput.bottomAnchor, constant: 48),
            inputsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            inputsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            inputsView.heightAnchor.constraint(equalToConstant: 32),
            
            quantityTextInput.centerYAnchor.constraint(equalTo: inputsView.centerYAnchor),
            quantityTextInput.heightAnchor.constraint(equalTo: inputsView.heightAnchor),
            quantityTextInput.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 0.2),
//            quantityTextInput.leadingAnchor.constraint(equalTo: inputsView.leadingAnchor, constant: 0),
            quantityTextInput.leadingAnchor.constraint(equalTo: productTextInput.trailingAnchor, constant: 4),

            
            productTextInput.centerYAnchor.constraint(equalTo: inputsView.centerYAnchor),
            productTextInput.heightAnchor.constraint(equalTo: inputsView.heightAnchor),
            productTextInput.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 0.6),
//            productTextInput.trailingAnchor.constraint(equalTo: inputsView.trailingAnchor, constant: 0),
            
            addProductButton.centerYAnchor.constraint(equalTo: inputsView.centerYAnchor),
            addProductButton.heightAnchor.constraint(equalTo: inputsView.heightAnchor),
            addProductButton.widthAnchor.constraint(equalToConstant: 32),
            addProductButton.trailingAnchor.constraint(equalTo: inputsView.trailingAnchor, constant: 0),
            
            productsTableView.topAnchor.constraint(equalTo: inputsView.bottomAnchor, constant: 24),
            productsTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            productsTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            productsTableView.bottomAnchor.constraint(equalTo: createListButton.topAnchor, constant: -16),
            
            createListButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            createListButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            createListButton.heightAnchor.constraint(equalToConstant: 45),
            createListButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

}
