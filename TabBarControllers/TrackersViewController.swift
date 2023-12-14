//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Марат Хасанов on 28.11.2023.
//

import UIKit
//Трекеры
class TrackersViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(TrackersHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(TrackersCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    //треккеры которые были выполнены в выбранную дату
    var completedTrackers: [TrackerRecord] = []
    
    var visibleTracker: [TrackerCategory] = []
    
    private var allCategories: [TrackerCategory] = [TrackerCategory(header: "Сдать бы ревью", tracker: [Tracker(id: 1, name: "Цветы", color: .c11, emoji: UIImage(named: "🌺") ?? UIImage(), timesheet: ["11": "45"])]),
                                                    TrackerCategory(header: "Сдать бы ревью2", tracker: [Tracker(id: 2, name: "Cмайлик", color: .c1, emoji: UIImage(named: "😂️️️️️️") ?? UIImage(), timesheet: ["11": "45"])])]
    
    //список категорий и трекеров в них
    var categories: [TrackerCategory] = []
    
    private var centerEmoji: UIImageView = {
        var view = UIImageView()
        let image = UIImage(named: "1")
        view = UIImageView(image: image)
        return view
    }()
    
    private var centerLabel: UILabel = {
        let label = UILabel()
        label.text = "Что будем отслеживать?"
        label.textColor = .udBlack
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    private let dataPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .compact
        picker.locale = .current
        picker.tintColor = .udBlack
        picker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        return picker
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
    
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupAllContraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: dataPicker)
    }
    
    @objc
    private func didTapPlusButton(_ sender: UIButton){
        let storyboard = UINavigationController(rootViewController: TrackerTypeViewController())
        present(storyboard, animated: true)
    }
    
    @objc
    func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let formattedDate = dateFormatter.string(from: selectedDate)
        Swift.print("Выбрали дату - \(formattedDate)")
    }
}

//Обновление текста
extension TrackersViewController: UISearchResultsUpdating {
    internal func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
}

extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 167, height: 148)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var id: String
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            id = "header"
        default:
            id = ""
        }
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: id, for: indexPath) as! TrackersHeader
        if categories.isEmpty{ return view }
        
        view.titleLabel.text = allCategories[indexPath.section].header
        return view
    }
}

extension TrackersViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return allCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allCategories[section].tracker.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TrackersCell
        let tracker: Tracker = allCategories[indexPath.section].tracker[indexPath.row]
        cell.setupTrackersCell(text: tracker.name, emoji: tracker.emoji, color: tracker.color, buttonTintColor: tracker.color, trackerID: tracker.id, counter: 1, completionFlag: false)
        return cell
    }
}
