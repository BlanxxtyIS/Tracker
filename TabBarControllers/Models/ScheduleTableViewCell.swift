//
//  ScheduleTableViewCell.swift
//  Tracker
//
//  Created by Марат Хасанов on 07.12.2023.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {    
    let identifier = "ScheduleTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: identifier)
        
        configCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configCell() {
        contentView.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
}
