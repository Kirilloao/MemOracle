//
//  ListViewController.swift
//  MemOracle
//
//  Created by Kirill Taraturin on 24.11.2023.
//

import UIKit

final class ListViewController: UITableViewController {
    
    // MARK: - Private Properties
    private var tableViewBuilder = TableViewBuilder(tableView: UITableView())
    
    // MARK: - Public Properties
    var mems: [Prediction] = []
    
    // MARK: - Init
    init() {
        super.init(style: .grouped)
        self.tableViewBuilder = TableViewBuilder(tableView: tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        registerCell()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTableView()
        tableView.reloadData()
    }
    
    // MARK: - Public Methods
    func updateTableView() {
        tableView.reloadData()
    }
    
    // MARK: - Private Methods
    private func setupTableView() {
        tableView.separatorStyle = .none
        
        let memCell = mems.map { mem -> CellModel in
            var cellModel = CellModel(identifier: "memCell")
            
            cellModel.onFill = { cell, indexPath in
                if let customCell = cell as? MemCell {
                    customCell.configure(with: mem)
                }
            }
            
            return cellModel
        }
        
        let memSection = SectionModel(cells: memCell)
        tableViewBuilder.sections = [memSection]
    }
    
    private func setViews() {
        view.backgroundColor = .white
        title = "Your predictions"
    }
    
    private func registerCell() {
        tableView.register(MemCell.self, forCellReuseIdentifier: "memCell")
    }
}
