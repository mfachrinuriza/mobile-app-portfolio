//
//  HomeRouter.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import Foundation
import core

protocol HomeRouterProtocol: AnyObject {
    var view: HomeViewControllerProtocol? { get set }
    
    func presentTransactionHistory()
}

class HomeRouter: HomeRouterProtocol {
    weak var view: HomeViewControllerProtocol?
    
    func presentTransactionHistory() {
        let vc = DI.get(TransactionHistoryViewControllerProtocol.self)!
        self.view?.navigationController?.pushViewController(vc, animated: true)
    }
}
