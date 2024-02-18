//
//  HomePresenter.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import Foundation
import Combine
import core

protocol HomePresenterProtocol: AnyObject {
    var interactor: HomeInteractorProtocol { get }

    var router: HomeRouterProtocol? { get set }
    var view: HomeViewControllerProtocol? { get set }
    
    func getDonutChartData()
    func getLineChartData()
}

class HomePresenter: HomePresenterProtocol {
    internal let interactor: HomeInteractorProtocol
    
    weak var router: HomeRouterProtocol?
    weak var view: HomeViewControllerProtocol?
    
    init(
        interactor: HomeInteractorProtocol
    ) {
        self.interactor = interactor
    }
    
    func getDonutChartData() {
        self.view?.update(with: self.interactor.getDonutChart())
    }
    
    func getLineChartData() {
        self.view?.update(with: self.interactor.getLineChart())
    }
}
