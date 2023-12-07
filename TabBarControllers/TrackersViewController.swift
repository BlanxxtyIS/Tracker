//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Марат Хасанов on 28.11.2023.
//

import UIKit

class TrackersViewController: UIViewController {
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(TrackersCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    //треккеры которые были выполнены в выбранную дату
    var completedTrackers: [TrackerRecord] = []
    
    var visibleTracker: [String] = []
    
    //список категорий и трекеров в них
    var categories: [TrackerCategory] = []
    
    private lazy var centerEmoji: UIImageView = {
        var view = UIImageView()
        let image = UIImage(named: "1")
        view = UIImageView(image: image)
        return view
    }()
    
    private lazy var centerLabel: UILabel = {
        let label = UILabel()
        label.text = "Что будем отслеживать?"
        label.textColor = .udBlack
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .udWhite
        
        setupAllViews()
        setupAllContraints()
        
        navBarItem()
        search()
    }
    
    private func search() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Поиск"
        navigationItem.searchController = search
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
            
            centerEmoji.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            centerEmoji.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),

            centerLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            centerLabel.topAnchor.constraint(equalTo: centerEmoji.bottomAnchor, constant: 8)
        ])
    }
    
    private func navBarItem() {
        //Кнопка "+"
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(Self.didTapPlusButton))
        plusButton.tintColor = .udBlack
        self.navigationItem.leftBarButtonItem = plusButton

        //Дата
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.locale = .current
        datePicker.tintColor = .udBlack
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: datePicker)
    }
    
    @objc
    func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let formattedDate = dateFormatter.string(from: selectedDate)
        Swift.print("Выбрали дату - \(formattedDate)")
    }
    
    @objc
    private func didTapPlusButton(_ sender: UIButton){
        let storyboard = UINavigationController(rootViewController: TrackerTypeViewController())
        present(storyboard, animated: true)
    }
}

//Обновление текста
extension TrackersViewController: UISearchResultsUpdating {
    internal func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
    
}
