//
//  NewHabit.swift
//  Tracker
//
//  Created by Марат Хасанов on 06.12.2023.
//

import UIKit

class NewHabit: UIViewController {
    
    private var habit: [String] = ["Категория", "Расписание"]
    
    private let trackerName: UITextField = {
        let name = UITextField()
        name.placeholder = "  Введите название трекера"
        name.translatesAutoresizingMaskIntoConstraints = false
        name.backgroundColor = .udBackground
        name.layer.cornerRadius = 16
        return name
    }()
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        table.separatorStyle = .none
        table.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        table.backgroundColor = .udBackground
        table.layer.masksToBounds = true
        table.layer.cornerRadius = 16
        table.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
//    private var colorCollectionView: UICollectionView = {
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
//        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: "cell")
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        return collectionView
//    }()
//    var colorCollection: [UIColor] = [.c1, .c2, .c3, .c4, .c5, .c6, .c7, .c8, .c9, .c10, .c11, .c12, .c13, .c14, .c15, .c16, .c17, .c18]
    
    private let cancelButton: UIButton = {
        let cancel = UIButton()
        cancel.setTitle("Отменить", for: .normal)
        cancel.layer.borderWidth = 1
        cancel.layer.borderColor = UIColor.udRed.cgColor
        cancel.setTitleColor(.udRed, for: .normal)
        cancel.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        cancel.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        cancel.layer.cornerRadius = 16
        cancel.translatesAutoresizingMaskIntoConstraints = false
        return cancel
    }()
    
    private let createButton: UIButton = {
        let create = UIButton()
        create.setTitle("Создать", for: .normal)
        create.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        create.backgroundColor = .udGray
        create.addTarget(self, action: #selector(createButtonClicked), for: .touchUpInside)
        create.layer.cornerRadius = 16
        create.translatesAutoresizingMaskIntoConstraints = false
        return create
    }()
    
    private var createButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .udWhite
        navigationItem.title = "Новая привычка"
        setupAllViews()
        setupAllConstraints()
//        colorCollectionView.register(ColorHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
    }
    
    private func setupAllConstraints() {
        NSLayoutConstraint.activate([
            trackerName.heightAnchor.constraint(equalToConstant: 75),
            trackerName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            trackerName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            trackerName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: trackerName.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 150),

//            colorCollectionView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
//            colorCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            colorCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            colorCollectionView.bottomAnchor.constraint(equalTo: createButtonStackView.topAnchor, constant: -16),
            
            createButtonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createButtonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            createButtonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            cancelButton.heightAnchor.constraint(equalToConstant: 60),
            createButton.heightAnchor.constraint(equalToConstant: 60)])
    }
    

    private func setupAllViews() {
        view.addSubview(trackerName)
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
//        view.addSubview(colorCollectionView)
//        colorCollectionView.delegate = self
//        colorCollectionView.dataSource = self
        
        view.addSubview(createButtonStackView)
        createButtonStackView.addArrangedSubview(cancelButton)
        createButtonStackView.addArrangedSubview(createButton)
    }
    
    @objc
    func cancelButtonClicked() {
        dismiss(animated: false)
        print("Отменить")
    }
    
    @objc
    func createButtonClicked() {
        dismiss(animated: false)
        print("Создать")
    }
}

extension NewHabit: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            print("Категория")
        } else if indexPath.row == 1 {
            print("Расписание")
            let storyboard = UINavigationController(rootViewController: ScheduleViewController())
            present(storyboard, animated: true)
        }
    }
}

extension NewHabit: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habit.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.textLabel?.text = self.habit[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .udBackground
        cell.heightAnchor.constraint(equalToConstant: 75).isActive = true
        return cell
    }
}

//extension NewHabit: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print(colorCollection.count)
//        return colorCollection.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ColorCell else {
//            return UICollectionViewCell()
//        }
//        cell.prepareForReuse()
//        cell.layer.cornerRadius = 8
//        cell.backgroundColor = colorCollection[indexPath.row]
//        return cell
//    }
//}

// Размер ячейки коллекции
//extension NewHabit: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 52, height: 52)
//        //return CGSize(width: collectionView.bounds.width / 6, height: 50)
//    }
//        
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 24, left: 18, bottom: 224, right: 18)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let id = "header"
//        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: id, for: indexPath) as! ColorHeader
//        view.titleLabel.font = .systemFont(ofSize: 19, weight: .bold)
//        view.titleLabel.text = "Цвет"
//        return view
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize { //Получает объект секции и возвращает размер секции
//            let indexPath = IndexPath(row: 0, section: section)
//            let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath) //получаем View.
//            return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel) // Передаем view возможность подсчитать свой размер и вернуть
//        }
//}

