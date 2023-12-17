//
//  TracekrsCell.swift
//  Tracker
//
//  Created by Марат Хасанов on 04.12.2023.
//

import UIKit

protocol TrackersCellDelegate: AnyObject {
    func competeTracker(id: UUID, at indexPath: IndexPath)
    func uncompleteTracker(id: UUID, at indexPath: IndexPath)
}

final class TrackersCell: UICollectionViewCell {
    
    var isCompleted: Bool = false
    weak var delegate: TrackersCellDelegate?
    var trackerId: UUID?
    var indexPath: IndexPath?
    
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
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            
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
    
    private func completionCountDaysText(completedDays: Int) -> String {
        let lasyNumber = completedDays % 10
        let lastTwoNumbers = completedDays % 100
        if lastTwoNumbers >= 11 && lastTwoNumbers <= 19 {
            return "\(completedDays) дней"
        }
        
        switch lasyNumber {
        case 1:
            return "\(completedDays) день"
        case 2, 3, 4:
            return "\(completedDays) дня"
        default:
            return "\(completedDays) дней"
        }
    }
    
    @objc
    func plusButtonClick() {
        guard let trackerId = trackerId, let indexPath = indexPath else {
            assertionFailure("Нету ID трекера")
            return
        }
        if isCompleted {
            delegate?.uncompleteTracker(id: trackerId, at: indexPath)
            isCompleted = false
        } else {
            delegate?.competeTracker(id: trackerId, at: indexPath)
            isCompleted = true
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
        
        let days = completionCountDaysText(completedDays: completedDays)
        dayLabel.text = days
        
        if isCompletedToday {
            plusDayButton.setImage(readyImage, for: .normal)
            plusDayButton.backgroundColor = tracker.color
        } else {
            plusDayButton.setImage(plusImage, for: .normal)
            plusDayButton.tintColor = tracker.color
        }
        
        adjustOpacity(to: isCompletedToday)
        
    }
    private func adjustOpacity(to isCompleted: Bool) {
        if isCompleted {
            plusDayButton.layer.opacity = 0.2
        } else {
            plusDayButton.layer.opacity = 1
        }
    }
    
}
