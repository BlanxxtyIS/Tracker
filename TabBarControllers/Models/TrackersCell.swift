//
//  TracekrsCell.swift
//  Tracker
//
//  Created by Марат Хасанов on 04.12.2023.
//

import UIKit

final class TrackersCell: UICollectionViewCell {
    
    var completionCount: Int = 0
    
    var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .udWhite
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var colorView: UIView = {
        let color = UIView()
        color.backgroundColor = .c5
        color.layer.masksToBounds = true
        color.layer.cornerRadius = 16
        color.translatesAutoresizingMaskIntoConstraints = false
        return color
    }()
    
    let emojiView: UIView = {
        let view = UIView()
        view.backgroundColor = .udBackground
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var emojiImage: UIImageView = {
        let emoji = UIImage(named: "ic 24x24")
        let image = UIImageView(image: emoji)
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var textLabel: UILabel = {
        var label = UILabel()
        label.text = "Мне очень нравится, верстка))"
        label.textColor = .udWhite
        label.textAlignment = .left
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var dayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .udBlack
        label.text = "0 дней"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var plusDayButton: UIButton = {
        let image = UIImage(named: "Plus")
        let plus = UIButton.systemButton(with: image!, target: self, action: #selector(plusButtonClicked))
        plus.tintColor = .c5
        plus.translatesAutoresizingMaskIntoConstraints = false
        plus.layer.masksToBounds = true
        return plus
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(cardView)
        cardView.addSubview(colorView)
        
        colorView.addSubview(emojiView)
        emojiView.addSubview(emojiImage)
        
        colorView.addSubview(textLabel)
        
        cardView.addSubview(dayLabel)
        cardView.addSubview(plusDayButton)
        
        //        contentView.addSubview(tracker)
        //        tracker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardView.heightAnchor.constraint(equalToConstant: 148),
            cardView.widthAnchor.constraint(equalToConstant: 167),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            
            emojiView.heightAnchor.constraint(equalToConstant: 24),
            emojiView.widthAnchor.constraint(equalToConstant: 24),
            emojiView.leadingAnchor.constraint(equalTo: colorView.leadingAnchor, constant: 12),
            emojiView.topAnchor.constraint(equalTo: colorView.topAnchor, constant: 12),
            
            emojiImage.heightAnchor.constraint(equalToConstant: 22),
            emojiImage.widthAnchor.constraint(equalToConstant: 16),
            emojiImage.centerYAnchor.constraint(equalTo: emojiView.centerYAnchor),
            emojiImage.centerXAnchor.constraint(equalTo: emojiView.centerXAnchor),
            
            textLabel.leadingAnchor.constraint(equalTo: colorView.leadingAnchor, constant: 12),
            textLabel.topAnchor.constraint(equalTo: emojiView.bottomAnchor, constant: 8),
            textLabel.trailingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: -12),
            textLabel.bottomAnchor.constraint(equalTo: colorView.bottomAnchor, constant: -12),
            
            dayLabel.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 16),
            dayLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            dayLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -24),
            dayLabel.widthAnchor.constraint(equalToConstant: 101),
            
            plusDayButton.widthAnchor.constraint(equalToConstant: 34),
            plusDayButton.heightAnchor.constraint(equalToConstant: 34),
            plusDayButton.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor, constant: 8),
            plusDayButton.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 8),
            plusDayButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
            
            colorView.topAnchor.constraint(equalTo: cardView.topAnchor),
            colorView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            colorView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            colorView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -58)])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func plusButtonClicked() {
        print("plus plus plus")
    }
    
    func setupTrackersCell(text: String,
                           emoji: String,
                           color: UIColor,
                           buttonTintColor: UIColor,
                           trackerID: UInt,
                           counter: Int,
                           completionFlag: Bool) {
        textLabel.text = text
        emojiImage.image = UIImage(named: emoji)
        colorView.backgroundColor = color
        plusDayButton.tintColor = buttonTintColor
        completionCount = counter
        //         trackerId = trackerID
        //         isCompletedToday = completionFlag)
    }
}
