//
//  TracekrsCell.swift
//  Tracker
//
//  Created by Марат Хасанов on 04.12.2023.
//

import UIKit

final class TrackersCell: UICollectionViewCell {
    let tracker = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(tracker)
        tracker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tracker.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            tracker.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
