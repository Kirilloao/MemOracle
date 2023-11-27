//
//  HeaderModel.swift
//  MemOracle
//
//  Created by Kirill Taraturin on 25.11.2023.
//

import UIKit

struct HeaderModel {
    var identifier: String
    var onFill: ((UITableViewHeaderFooterView) -> Void)?
}
