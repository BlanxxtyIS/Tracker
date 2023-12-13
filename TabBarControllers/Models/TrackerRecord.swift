//
//  TrackerRecord.swift
//  Tracker
//
//  Created by Марат Хасанов on 04.12.2023.
//

import Foundation
//Для хранения записи о том, что некий треккер был выполнен на дату

struct TrackerRecord {
    let id: UUID
    let date: [Date]
    let days: Int
    let tracker: Tracker
}
