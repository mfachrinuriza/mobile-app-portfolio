//
//  HomeInteractor_Test.swift
//  mobile-app-portfolioTests
//
//  Created by Muhammad Fachri Nuriza on 18/02/24.
//

import XCTest
import core
import Swinject
import SwinjectAutoregistration
@testable import mobile_app_portfolio

final class HomeInteractor_Test: XCTestCase {

    let container = Container()
 
    override func setUpWithError() throws {
        // Storage
        container.autoregister(StorageProtocol.self, initializer: Storage.init)
        container.autoregister(SecureStorageProtocol.self, initializer: SecureStorage.init)

        // Home Interactor
        container.autoregister(HomeInteractorProtocol.self, initializer: HomeInteractor.init)
    }
    
    override func tearDownWithError() throws {
        container.removeAll()
    }
    
    func test_getAmount_success() {
        let sut = container ~> HomeInteractorProtocol.self
        let sutDonutData = sut.getDonutChart()
        
        // Retrieve DonutChart data from the JSON file
        guard let rscDonutData: [DonutChart] = FileReader.readJSON(file: "DonutChartData", type: [DonutChart].self) else {
            XCTFail("Failed to read DonutChart data from JSON")
            return
        }
        
        // Compare the retrieved data
        XCTAssertEqual(sutDonutData, rscDonutData)
    }

}
