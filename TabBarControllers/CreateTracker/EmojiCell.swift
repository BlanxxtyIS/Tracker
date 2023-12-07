//
//  EmojiCell.swift
//  Tracker
//
//  Created by Марат Хасанов on 06.12.2023.
//

import UIKit

class EmojiCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
