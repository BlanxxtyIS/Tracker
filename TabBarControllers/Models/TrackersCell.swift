//
//  TracekrsCell.swift
//  Tracker
//
//  Created by Марат Хасанов on 04.12.2023.
//

import UIKit

protocol TrackersCellDelegate: AnyObject {
    func competeTracker(id: UUID)
    func uncompleteTracker(id: UUID)
}

final class TrackersCell: UICollectionViewCell {

    var isCompleted: Bool?
    var trackerId: UUID?
    var indexPath: IndexPath?
    
    weak var delegate: TrackersCellDelegate?
    
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
    
    var emojiImage: UILabel = {
        let emoji = UILabel()
        emoji.numberOfLines = 1
        emoji.textAlignment = .center
        emoji.textColor = .udWhite
        emoji.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        emoji.backgroundColor = .udBackground
        emoji.layer.masksToBounds = true
        emoji.layer.cornerRadius = 12
        emoji.translatesAutoresizingMaskIntoConstraints = false
        return emoji
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
        let button = UIButton(type: .system)
        let pointSize = UIImage.SymbolConfiguration(pointSize: 11)
        let image = UIImage(systemName: "plus", withConfiguration: pointSize)
        button.tintColor = .udWhite
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 34 / 2
        button.addTarget(self, action: #selector(plusButtonClick), for: .touchUpInside)
        return button
    }()
    
    private lazy var readyImage: UIImage = {
        let image = UIImage(named: "done_icon") ?? UIImage()
        return image
    }()
    
    private lazy var plusImage: UIImage = {
        let size = UIImage.SymbolConfiguration(pointSize: 11)
        let image = UIImage(named: "Plus") ?? UIImage()
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAllViewContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAllViewContraints() {
        contentView.addSubview(cardView)
        cardView.addSubview(colorView)
        
        colorView.addSubview(emojiImage)
        
        colorView.addSubview(textLabel)
        
        cardView.addSubview(dayLabel)
        cardView.addSubview(plusDayButton)
        
        NSLayoutConstraint.activate([
            cardView.heightAnchor.constraint(equalToConstant: 148),
            cardView.widthAnchor.constraint(equalToConstant: 167),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            colorView.topAnchor.constraint(equalTo: cardView.topAnchor),
            colorView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            colorView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            colorView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -58),
            
            emojiImage.heightAnchor.constraint(equalToConstant: 24),
            emojiImage.widthAnchor.constraint(equalToConstant: 24),
            emojiImage.topAnchor.constraint(equalTo: colorView.topAnchor, constant: 12),
            emojiImage.leadingAnchor.constraint(equalTo: colorView.leadingAnchor, constant: 12),
            
            textLabel.leadingAnchor.constraint(equalTo: colorView.leadingAnchor, constant: 12),
            textLabel.topAnchor.constraint(equalTo: emojiImage.bottomAnchor, constant: 8),
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
            plusDayButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12)])
    }
    
    private func completionCountDaysText(completedDays: Int){
        let remainder = completedDays % 100
        
        if (11...14).contains(remainder) {
            dayLabel.text = "\(completedDays) дней"
        } else {
            switch remainder % 10 {
            case 1:
                dayLabel.text = "\(completedDays) день"
            case 2...4:
                dayLabel.text = "\(completedDays) дня"
            default:
                dayLabel.text = "\(completedDays) дней"
            }
        }
    }
    
    @objc
    func plusButtonClick() {
        guard let isCompleted = isCompleted,
              let trackerID = trackerId
        else {
            return
        }
        if isCompleted {
            delegate?.uncompleteTracker(id: trackerID)
        } else {
            delegate?.competeTracker(id: trackerID)

        }
    }
    
    func configure(
        with tracker: Tracker,
        isCompletedToday: Bool,
        completedDays: Int,
        indexPath: IndexPath
    ) {
        self.trackerId = tracker.id
        self.isCompleted = isCompletedToday
        self.indexPath = indexPath
        
        colorView.backgroundColor = tracker.color
        
        textLabel.text = tracker.text
        emojiImage.text = tracker.emoji
        completionCountDaysText(completedDays: completedDays)
        
        let image = isCompleted! ? UIImage(systemName: "checkmark") : UIImage(systemName: "plus")
        let imageview = UIImageView(image: image)
        
        plusDayButton.backgroundColor = isCompletedToday ? tracker.color.withAlphaComponent(0.3) : tracker.color
        colorView.backgroundColor = tracker.color
        for view in self.plusDayButton.subviews {
            view.removeFromSuperview()
        }
        plusDayButton.addSubview(imageview)
        
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.centerXAnchor.constraint(equalTo: plusDayButton.centerXAnchor).isActive = true
        imageview.centerYAnchor.constraint(equalTo: plusDayButton.centerYAnchor).isActive = true
        
    }
    
}
