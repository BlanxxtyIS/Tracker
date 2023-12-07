//
//  EmojiCell.swift
//  Tracker
//
//  Created by Марат Хасанов on 06.12.2023.
//

import UIKit

class EmojiCell: UICollectionViewCell {
    
    let identifier = "EmojiCell"
    
    var emojiCell: UIImageView = {
        var emoji = UIImageView()
        let emojiCell = UIImage(named: "")
        emoji = UIImageView(image: emojiCell)
        return emoji
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(emojiCell)
        emojiCell.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emojiCell.heightAnchor.constraint(equalToConstant: 38),
            emojiCell.widthAnchor.constraint(equalToConstant: 32),
            emojiCell.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emojiCell.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
