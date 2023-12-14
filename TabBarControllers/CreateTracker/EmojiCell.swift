//
//  EmojiCell.swift
//  Tracker
//
//  Created by Марат Хасанов on 06.12.2023.
//

import UIKit

class EmojiCell: UICollectionViewCell {
    
    let identifier = "EmojiCell"
    
    private lazy var emojiImageView: UIImageView = {
        var emoji = UIImageView()
        let emojiCell = UIImage(named: "")
        emoji = UIImageView(image: emojiCell)
        return emoji
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(emojiImageView)
        emojiImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emojiImageView.heightAnchor.constraint(equalToConstant: 38),
            emojiImageView.widthAnchor.constraint(equalToConstant: 32),
            emojiImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emojiImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
