//
//  TableViewCell.swift
//  Tracker
//
//  Created by Марат Хасанов on 07.12.2023.
//

import UIKit

//После выбора показывает категорию или расписание
struct TableViewSetting {
    let name: String
    let pickedParameter: Any?
    let handler: () -> Void
}
