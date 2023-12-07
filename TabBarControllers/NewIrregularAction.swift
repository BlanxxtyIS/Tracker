//
//  NewIrregularAction.swift
//  Tracker
//
//  Created by Марат Хасанов on 07.12.2023.
//

import UIKit

class NewIrregularAction: UIViewController {
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Назад", for: .normal)
        button.setTitleColor(.udBlack, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = .udWhite
        button.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .udWhite
        navigationItem.title = "Нерегулрные события"
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)])
    }
    @objc
    func backButtonClicked() {
        dismiss(animated: false)
        print("назад")
    }
}
