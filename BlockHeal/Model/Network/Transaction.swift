//
//  Transaction.swift
//  BlockHeal
//
//  Created by ali on 6/15/20.
//  Copyright © 2020 Alireza. All rights reserved.
//

import Foundation

// MARK: - Transaction
struct TransactionData: Codable {
    var actionName: String?
    var metaData: MetaData?
}

// MARK: - MetaData
struct MetaData: Codable {
    var title, message, messageEnglish: String?
}
