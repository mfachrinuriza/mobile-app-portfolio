//
//  HomeInteractor.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import Foundation
import core

protocol HomeInteractorProtocol: AnyObject {
    func getDonutChart() -> [DonutChart]
    func getLineChart() -> LineChart?
}

class HomeInteractor: HomeInteractorProtocol {
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
    
    func getDonutChart() -> [DonutChart] {
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
    
    func getLineChart() -> LineChart? {
        if let chartData = self.getPortfolioList().first(where: { $0.type == "lineChart" }) {
            switch chartData.data {
            case .lineChart(let lineChartData):
                return lineChartData
            default:
                return nil
            }
        } else {
            return nil
        }
    }
}
