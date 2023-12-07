//
//  Schedule.swift
//  Tracker
//
//  Created by Марат Хасанов on 07.12.2023.
//

import UIKit
enum WeekDay: String, CaseIterable {
    case Понедельник, Вторник, Среда, Четверг, Пятница, Суббота, Воскресенье
}

class ScheduleViewController: UIViewController {
    
    let weekDay: [String] = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    
    let scheduleTableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.register(TableViewCell.self, forCellReuseIdentifier: "ScheduleTableViewCell")
        table.separatorStyle = .none
        table.backgroundColor = .udBackground
        table.isScrollEnabled = false
        table.layer.masksToBounds = true
        table.layer.cornerRadius = 16
        table.separatorStyle = .singleLine
        table.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let readyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Готово", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = .udBlack
        button.addTarget(self, action: #selector(didReadyButton), for: .touchUpInside)
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .udWhite
        navigationItem.title = "Расписание"
        setupAllViews()
        setupAllConstraints()
    }
    
    @objc
    func didReadyButton() {
        print("Готово")
        dismiss(animated: true)
    }
    
    private func setupAllViews() {
        view.addSubview(scheduleTableView)
        view.addSubview(readyButton)
        scheduleTableView.dataSource = self
        scheduleTableView.delegate = self
    }
    
    private func setupAllConstraints() {
        let safe = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            scheduleTableView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 16),
            scheduleTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scheduleTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scheduleTableView.bottomAnchor.constraint(equalTo: readyButton.topAnchor, constant: -47),
        
            readyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            readyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            readyButton.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: 0),
            readyButton.heightAnchor.constraint(equalToConstant: 60)])
    }
    @objc func switchChanged(_ sender: UISwitch!) {
        print("\(sender.tag)")
        print("\(sender.isOn ? "ON" : "OFF")")
    }
}

extension ScheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekDay.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if let reusedCell = tableView.dequeueReusableCell(withIdentifier: "ScheduleViewController") {
            cell = reusedCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "ScheduleViewController")
        }
        cell.textLabel?.text = weekDay[indexPath.row]
        
        let switcher = UISwitch(frame: .zero)
        switcher.setOn(false, animated: true)
        switcher.tag = indexPath.row
        switcher.onTintColor = .udBlue
        switcher.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        cell.accessoryView = switcher
        
        cell.heightAnchor.constraint(equalToConstant: 82).isActive = true
        cell.backgroundColor = .udBackground
        return cell
    }
}


