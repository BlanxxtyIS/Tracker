//
//  StatisticsViewController.swift
//  Tracker
//
//  Created by Марат Хасанов on 28.11.2023.
//

import UIKit
//Статистика
class StatisticsViewController: UIViewController {

    private lazy var centerEmoji: UIImageView = {
        var view = UIImageView()
        let image = UIImage(named: "3")
        view = UIImageView(image: image)
        return view
    }()
    
    private lazy var centerLabel: UILabel = {
        var label = UILabel()
        label.text = "Анализировать пока нечего"
        label.textColor = .udBlack
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        setupAllViews()
        setupAllContraints()
    }
    
    private func setupAllViews() {
        centerEmoji.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(centerEmoji)
        
        centerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(centerLabel)
    }
    
    private func setupAllContraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            centerEmoji.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            centerEmoji.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            
            centerLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            centerLabel.topAnchor.constraint(equalTo: centerEmoji.bottomAnchor, constant: 8)
        ])
    }

}

