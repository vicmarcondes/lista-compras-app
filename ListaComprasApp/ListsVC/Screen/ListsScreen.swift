//
//  ListsScreen.swift
//  ListaComprasApp
//
//  Created by admin on 08/02/24.
//

import UIKit

class ListsScreen: UIView {
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(ListsTableViewCell.self, forCellReuseIdentifier: ListsTableViewCell.identifier)
        tv.backgroundColor = .appBlue
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSubview()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configDelegateAndDatasource(delegate: UITableViewDelegate, detasource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = detasource
    }
    
    private func configSubview() {
        addSubview(tableView)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
