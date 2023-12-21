//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Марат Хасанов on 28.11.2023.
//

import UIKit
//Трекеры
class TrackersViewController: UIViewController {
    
    //треккеры которые были выполнены в выбранную дату
    var completedTrackers: [TrackerRecord] = []
    
    var visibleCategories: [TrackerCategory] = []
    
    //список категорий и трекеров в них
    var categories: [TrackerCategory] = [TrackerCategory(header: "Первый треккер", tracker: [Tracker(id: UUID(), color: .c1, emoji: "🌺", text: "Сдать ревью", schedule: [.friday, .monday, .saturday, .thursday]), Tracker(id: UUID(), color: .c16, emoji: "😂️️️️️️", text: "мок данные", schedule: [.friday, .monday])]), TrackerCategory(header: "Уже 15 скоро", tracker: [Tracker(id: UUID(), color: .c4, emoji: "🔥️️️️️️", text: "Запутався", schedule: [.friday, .monday])])]
    
    private let widthParameters = CollectionParameters(cellsNumber: 2, leftInset: 16, rightInset: 16, interCellSpacing: 10)
    
    private let emptyImage = UIImageView(image: UIImage(named: "1"))
    private let emptyText: UILabel = {
        let label = UILabel()
        label.text = "Что будем отслеживать?"
        label.textColor = UIColor.udBlack
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let errorImage = UIImageView(image: UIImage(named: "3"))
    private let errorText: UILabel = {
        let label = UILabel()
        label.text = "Ничего не найдено"
        label.textColor = UIColor.udBlack
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var currentDate: Date = Date()
    var completedDays: [Date] = []
    var selectedDate = Date()
    
    var userSearch = ""
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(TrackersHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(TrackersCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var searchBar: UISearchTextField = {
        let textField = UISearchTextField()
        textField.textColor = .udBlack
        textField.font = .systemFont(ofSize: 17, weight: .medium)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.udGray]
        let attributedPlaceholder = NSAttributedString(string: "Поиск", attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .compact
        picker.tintColor = .udBlue
        picker.locale = Locale(identifier: "ru_RU")
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .udWhite
        visibleCategories = categories
        navBarItem()
        setupCollectionView()
        setupEmptyConstraints()
    }
    
    //MARK: Setup EmptyView
    private func showEmptyView() {
        emptyImage.isHidden = false
        emptyText.isHidden = false
    }
    private func dismissEmptyView() {
        emptyImage.isHidden = true
        emptyText.isHidden = true
    }
    
    private func showErrorView() {
        errorImage.isHidden = false
        errorText.isHidden = false
    }
    private func dismissErrorView() {
        errorImage.isHidden = true
        errorText.isHidden = true
    }
    
    func setupEmptyConstraints() {
        self.view.backgroundColor = UIColor.udWhite
        visibleCategories.isEmpty ? showEmptyView() : dismissEmptyView()
        dismissErrorView()
        setupCollectionView()
        
        emptyImage.translatesAutoresizingMaskIntoConstraints = false
        errorImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyImage)
        view.addSubview(emptyText)
        view.addSubview(errorImage)
        view.addSubview(errorText)
        NSLayoutConstraint.activate([
            emptyImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            emptyImage.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            emptyText.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            emptyText.topAnchor.constraint(equalTo: emptyImage.bottomAnchor, constant: 8),
            errorImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            errorImage.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            errorText.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            errorText.topAnchor.constraint(equalTo: emptyImage.bottomAnchor, constant: 8),
        ])
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
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
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
        let viewController = TrackerTypeViewController()
        viewController.delegate = self
        present(viewController, animated: true)
    }
    
    //MARK: - DatePicker
    @objc func datePickerChanged() {
        visibleCategories = []
        selectedDate = datePicker.date
        for category in categories {
            var dateSortedTrackers: [Tracker] = []
            
            for tracker in category.tracker {
                guard let weekDay = WeekDays(rawValue: calculateWeekDayNumber(for: selectedDate)) else { continue }
                guard let doesContain = tracker.schedule?.contains(weekDay) else {continue}
                if doesContain {
                    dateSortedTrackers.append(tracker)
                }
                
                
            }
            if !dateSortedTrackers.isEmpty {
                visibleCategories.append(TrackerCategory(header: category.header, tracker: dateSortedTrackers))
            }
        }
        visibleCategories.isEmpty ? showEmptyView() : dismissEmptyView()
        dismissErrorView()
        collectionView.reloadData()
    }
    
    //MARK: - SEARCH
    private func didChangeSearchText() {
        guard let searchText = searchBar.text,
              !searchText.isEmpty
        else {
            dismissErrorView()
            visibleCategories = categories
            collectionView.reloadData()
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
        visibleCategories = searchedCategories
        collectionView.reloadData()
        visibleCategories.isEmpty ? showErrorView() : dismissErrorView()
        dismissEmptyView()
        
    }
    
    private func isMatchRecord(model: TrackerRecord, with trackerId: UUID) -> Bool {
        return model.id == trackerId && Calendar.current.isDate(model.date, inSameDayAs: selectedDate)
    }
    
    func calculateWeekDayNumber(for date: Date) -> Int {
        var calendar = Calendar.current
        calendar.firstWeekday = 2
        let weekDay = calendar.component(.weekday, from: date)
        let daysWeek = 7
        return (weekDay - calendar.firstWeekday + daysWeek) % daysWeek + 1
    }
    
    func updateVisibleTrackers() {
        visibleCategories = []
        
        for category in categories {
            var visibleTrackers: Array<Tracker> = []
            
            for tracker in category.tracker {
                guard let weekDay = WeekDays(rawValue: calculateWeekDayNumber(for: selectedDate)),
                      ((tracker.schedule?.contains(weekDay)) != nil)
                else {
                    continue
                }
                visibleTrackers.append(tracker)
            }
            if !visibleTrackers.isEmpty {
                visibleCategories.append(TrackerCategory(header: category.header, tracker: visibleTrackers))
            }
        }
        visibleCategories.isEmpty ? showEmptyView() : dismissEmptyView()
        dismissErrorView()
        collectionView.reloadData()
    }
}

//MARK: - UITextFieldDelegate
extension TrackersViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        didChangeSearchText()
        return true
    }
}

//MARK: - UICollectionView
extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    
    //размер ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.bounds.width - widthParameters.widthInsets
        let cellWidth = availableWidth / CGFloat(widthParameters.cellsNumber)
        return CGSize(width: cellWidth, height: 148)
    }
    
    //отступы от краев
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: widthParameters.leftInset, bottom: 8, right: widthParameters.rightInset)
    }
    
    //вертикальные отступы
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //горизонтальные отступы
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        let targetSize = CGSize(width: collectionView.bounds.width, height: 42)
        
        return headerView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .required)
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TrackersCell else {
            preconditionFailure("Ошибка с ячейкой")
        }
        let tracker = visibleCategories[indexPath.section].tracker[indexPath.row]
        let isCompleted = completedTrackers.contains {
            isMatchRecord(model: $0, with: tracker.id)
        }
        let completedDays = completedTrackers.filter { $0.id == tracker.id }.count

        cell.delegate = self
        
        let isCompletedToday = isTrackerCompletedToday(id: tracker.id)
        cell.configure(with: tracker, isCompletedToday: isCompletedToday, completedDays: completedDays, indexPath: indexPath)

        return cell
    }
    
    private func isTrackerCompletedToday(id: UUID) -> Bool {
        completedTrackers.contains { trackerRecord in
            let isSameDay = Calendar.current.isDate(trackerRecord.date, inSameDayAs: datePicker.date)
            return trackerRecord.id == id && isSameDay
        }
    }
}

//MARK: - TrackersCell
extension TrackersViewController: TrackersCellDelegate {
    
    func competeTracker(id: UUID, at indexPath: IndexPath) {
        let trackerRecord = TrackerRecord(id: id, date: datePicker.date)
        completedTrackers.append(trackerRecord)
        collectionView.reloadItems(at: [indexPath])
    }
    
    func uncompleteTracker(id: UUID, at indexPath: IndexPath ) {
        completedTrackers.removeAll { trackerRecord in
            let isSameDay = Calendar.current.isDate(trackerRecord.date, inSameDayAs: datePicker.date)
            return trackerRecord.id == id && isSameDay
        }
        collectionView.reloadItems(at: [indexPath])
    }
    
    private func isSameTrackerRecord(trackerRecord: TrackerRecord, id: UUID) -> Bool {
        let isSameDay = Calendar.current.isDate(trackerRecord.date,
                                                inSameDayAs: datePicker.date)
        return trackerRecord.id == id && isSameDay
    }
}

extension TrackersViewController: TrackerTypeViewControllerDelegate {
    func createNewTracker(traker: Tracker) {
        categories[0].tracker.append(traker)
        updateVisibleTrackers()
        collectionView.reloadData()
    }
}
