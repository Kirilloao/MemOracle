//
//  TableViewBuilder.swift
//  MemOracle
//
//  Created by Kirill Taraturin on 25.11.2023.
//

import UIKit

final class TableViewBuilder: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Public Properties
    var sections: [SectionModel] = []
    
    // MARK: - Init
    init(tableView: UITableView) {
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = sections[indexPath.section].cells[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.identifier, for: indexPath)
        
        cellModel.onFill?(cell, indexPath)
        return cell
    }
    
    // MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellModel = sections[indexPath.section].cells[indexPath.row]
        cellModel.onSelect?(indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let identifier = sections[section].header?.identifier ?? ""
        
        guard
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier)
        else {
            return UITableViewHeaderFooterView()
        }
        
        sections[section].header?.onFill?(header)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let minHeight: CGFloat = 80 // Задайте минимальную высоту
        return max(minHeight, UITableView.automaticDimension)
    }
}
