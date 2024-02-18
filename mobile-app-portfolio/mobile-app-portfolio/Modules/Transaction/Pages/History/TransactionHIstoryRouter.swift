//
//  TransactionHIstoryRouter.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 14/02/24.
//

import Foundation
import core

protocol TransactionHistoryRouterProtocol: AnyObject {
    var view: TransactionHistoryViewControllerProtocol? { get set }
    func presentTransactionDetail(with detail: DonutChart)
}

class TransactionHistoryRouter: TransactionHistoryRouterProtocol {
    weak var view: TransactionHistoryViewControllerProtocol?
    
    func presentTransactionDetail(with detail: DonutChart) {
        let vc = DI.get(TransactionDetailViewControllerProtocol.self)!
        vc.detail = detail
        self.view?.navigationController?.pushViewController(vc, animated: true)
    }
}
