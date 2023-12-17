//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Марат Хасанов on 28.11.2023.
//

import UIKit
//Трекеры
class TrackersViewController: UIViewController {
    
    var currentDate: Date = Date()
    var completedDays: [Date] = []
    
    var userSearch = ""
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(TrackersHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(TrackersCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Поиск"
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.addTarget(self, action: #selector(didChangeSearchText), for: .allEvents)
        return searchBar
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .compact
        picker.datePickerMode = .date
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.tintColor = .udBlack
        picker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        return picker
    }()
    
    
    //треккеры которые были выполнены в выбранную дату
    var completedTrackers: [TrackerRecord] = []
    
    var visibleCategories: [TrackerCategory] = []
    
    //список категорий и трекеров в них
    var categories: [TrackerCategory] = []
    
    //Моковые данные
    var collectionTracker: [TrackerCategory] = [TrackerCategory(header: "Первый треккер", tracker: [Tracker(id: UUID(), color: .c1, emoji: "🌺", text: "Сдать ревью", schedule: Date()), Tracker(id: UUID(), color: .c16, emoji: "😂️️️️️️", text: "мок данные", schedule: Date())]), TrackerCategory(header: "Уже 15 скоро", tracker: [Tracker(id: UUID(), color: .c4, emoji: "😂️️️️️️", text: "Запутався", schedule: Date())])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //search()
        view.backgroundColor = .udWhite
        selectedView()
        navBarItem()
        
    }
    
    func selectedView() {
        if visibleCategories.isEmpty {
            setupEmptyView()
        } else {
            setupCollectionView()
        }
    }
    
    func setupCollectionView() {
        setupAllViews()
        setupAllContraints()
    }

    private func setupAllViews() {
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupAllContraints() {
        NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 24),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func navBarItem() {
        //Кнопка "+"
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(Self.didTapPlusButton))
        plusButton.tintColor = .udBlack
        self.navigationItem.leftBarButtonItem = plusButton

        //Дата
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: datePicker)
        
    }
    
    @objc
    private func didTapPlusButton(_ sender: UIButton){
        let storyboard = UINavigationController(rootViewController: TrackerTypeViewController())
        setupCollectionView()
        visibleCategories = collectionTracker
        present(storyboard, animated: true)
    }
    
    @objc private func datePickerValueChanged() {
        currentDate = datePicker.date
        completedDays.append(currentDate)
        collectionView.reloadData()
    }
    
    @objc func didChangeSearchText() {
        guard let searchText = searchBar.text,
              !searchText.isEmpty
        else {
            return
        }
        var searchedCategories: [TrackerCategory] = []
        for category in categories {
            var searchedTrackers: [Tracker] = []
            
            for tracker in category.tracker {
                if tracker.text.localizedCaseInsensitiveContains(searchText) {
                    searchedTrackers.append(tracker)
                }
            }
            if !searchedTrackers.isEmpty {
                searchedCategories.append(TrackerCategory(header: category.header, tracker: searchedTrackers))
            }
        }
        collectionView.reloadData()
        visibleCategories = searchedCategories
//        visibleCategories.isEmpty ? setupEmptyView() : l()
//        hidePlaceholder()
//        trackerCollection.reloadData()
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
        view.titleLabel.text = visibleCategories.isEmpty ? "" : visibleCategories[indexPath.section].header
        return view
    }
}

extension TrackersViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return visibleCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return visibleCategories.isEmpty ? 0 : visibleCategories[section].tracker.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TrackersCell
        let tracker = visibleCategories[indexPath.section].tracker[indexPath.row]
        cell.delegate = self
        
        let isCompletedToday = isTrackerCompletedToday(id: tracker.id)
        let completedDays = completedTrackers.filter {
            $0.id == tracker.id
        }.count
        
        cell.configure(
            with: tracker,
            isCompletedToday: isCompletedToday,
            completedDays: completedDays,
            indexPath: indexPath)
        return cell
    }
    
    private func isTrackerCompletedToday(id: UUID) -> Bool {
        completedTrackers.contains { trackerRecord in
            isSameTrackerRecord(trackerRecord: trackerRecord, id: id)
        }
    }
}

extension TrackersViewController: TrackersCellDelegate {
    
    func competeTracker(id: UUID, at indexPath: IndexPath) {
        let trackerRecord = TrackerRecord(id: id, date: datePicker.date)
        completedTrackers.append(trackerRecord)
        collectionView.reloadItems(at: [indexPath])
    }
    
    func uncompleteTracker(id: UUID, at indexPath: IndexPath) {
        completedTrackers.removeAll { trackerRecord in
            isSameTrackerRecord(trackerRecord: trackerRecord, id: id)
        }
        collectionView.reloadItems(at: [indexPath])
    }
    
    private func isSameTrackerRecord(trackerRecord: TrackerRecord, id: UUID) -> Bool {
        let isSameDay = Calendar.current.isDate(trackerRecord.date,
                                                inSameDayAs: datePicker.date)
        return trackerRecord.id == id && isSameDay
    }
}

extension TrackersViewController {
    private func setupEmptyView() {
        var centerEmoji: UIImageView = {
            var view = UIImageView()
            let image = UIImage(named: "1")
            view = UIImageView(image: image)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        var centerLabel: UILabel = {
            let label = UILabel()
            label.text = "Что будем отслеживать?"
            label.textColor = .udBlack
            label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        view.addSubview(searchBar)
        view.addSubview(centerEmoji)
        view.addSubview(centerLabel)
        
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            centerEmoji.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerEmoji.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            centerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerLabel.topAnchor.constraint(equalTo: centerEmoji.bottomAnchor, constant: 8)])
    }
}

