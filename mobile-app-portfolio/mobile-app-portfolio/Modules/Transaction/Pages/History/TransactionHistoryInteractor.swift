//
//  TransactionHistoryInteractor.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 14/02/24.
//

import Foundation
import core

protocol TransactionHistoryInteractorProtocol: AnyObject {
    func getTransactionHistory() -> [DonutChart]
}

class TransactionHistoryInteractor: TransactionHistoryInteractorProtocol {
    internal let storage: StorageProtocol
    internal let secureStorage: SecureStorageProtocol

    init(
        storage: StorageProtocol,
        secureStorage: SecureStorageProtocol
    ) {
        self.storage = storage
        self.secureStorage = secureStorage
    }
    
    func getPortfolioList() -> [ChartData] {
        var result = [ChartData]()
        let file = "portofolio"
        
        if let url = Bundle.main.url(forResource: file, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                result = try decoder.decode([ChartData].self, from: data)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("File not found")
        }
        
        return result
    }
    
    func getTransactionHistory() -> [DonutChart] {
        if let chartData = self.getPortfolioList().first(where: { $0.type == "donutChart" }) {
            switch chartData.data {
            case .donutChart(let donutChartData):
                return donutChartData
            default:
                return []
            }
        } else {
            return []
        }
    }
}
