//
//  CellModel.swift
//  MemOracle
//
//  Created by Kirill Taraturin on 25.11.2023.
//

import UIKit

struct CellModel {
    let identifier: String
    var onFill: ((UITableViewCell, IndexPath) -> Void)?
    var onSelect: ((IndexPath) -> Void)?
}
