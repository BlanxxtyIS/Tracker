//
//  EmojiCell.swift
//  Tracker
//
//  Created by Марат Хасанов on 06.12.2023.
//

import UIKit

final class ColorCell: UICollectionViewCell {
    
    let identifier = "ColorCell"
    
    let viewColor: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(viewColor)
        viewColor.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            viewColor.heightAnchor.constraint(equalToConstant: 40),
            viewColor.widthAnchor.constraint(equalToConstant: 40),
            viewColor.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            viewColor.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
