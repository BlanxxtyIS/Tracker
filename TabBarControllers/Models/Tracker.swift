//
//  Tracker.swift
//  Tracker
//
//  Created by Марат Хасанов on 04.12.2023.
//

import UIKit

//Для хранения информации про трекер
struct Tracker {
    let id: UUID
    let name: String
    let color: UIColor
    let emoji: String
    let timesheet: [String: String]
}
