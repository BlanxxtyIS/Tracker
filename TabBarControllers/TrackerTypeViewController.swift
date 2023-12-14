//
//  TrackerTypeViewController.swift
//  Tracker
//
//  Created by Марат Хасанов on 05.12.2023.
//

import UIKit
//Трекеры - Тип трекера
class TrackerTypeViewController: UIViewController {
    
    private var createHabit: UIButton = {
        let habit = UIButton()
        habit.setTitle("Привычка", for: .normal)
        habit.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        habit.backgroundColor = .udBlack
        habit.addTarget(self, action: #selector(createHabitButton), for: .touchUpInside)
        habit.layer.cornerRadius = 16
        habit.translatesAutoresizingMaskIntoConstraints = false
        return habit
    }()
    
    private var createAnIrregularEvents: UIButton = {
        let inRegularEvents = UIButton()
        inRegularEvents.setTitle("Нерегулярные события", for: .normal)
        inRegularEvents.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        inRegularEvents.backgroundColor = .udBlack
        inRegularEvents.addTarget(self, action: #selector(createAnIrregularEventsButton), for: .touchUpInside)
        inRegularEvents.layer.cornerRadius = 16
        inRegularEvents.translatesAutoresizingMaskIntoConstraints = false
        return inRegularEvents
    }()
    
    private var createStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .udWhite
        navigationItem.title = "Создание трекера"
        
        setupAllViews()
        setupAllConstraint()
    }
    
    private func setupAllConstraint() {
        let safe = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            createHabit.heightAnchor.constraint(equalToConstant: 60),
            createAnIrregularEvents.heightAnchor.constraint(equalToConstant: 60),
            
            createStackView.centerXAnchor.constraint(equalTo: safe.centerXAnchor),
            createStackView.centerYAnchor.constraint(equalTo: safe.centerYAnchor),
            createStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)])
    }
    
    private func setupAllViews() {
        view.addSubview(createStackView)
        createStackView.addArrangedSubview(createHabit)
        createStackView.addArrangedSubview(createAnIrregularEvents)
    }
    
    @objc
    func createHabitButton() {
        print("Привычка")
        let storyboard = UINavigationController(rootViewController: NewHabitViewController())
        present(storyboard, animated: true)
    }
    
    @objc
    func createAnIrregularEventsButton() {
        print("Нерегулярное событие")
        let storyboard = UINavigationController(rootViewController: NewIrregularAction())
        present(storyboard, animated: true)
    }
}
