//
//  TransactionHIstoryPresenter.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 14/02/24.
//

import Foundation
import Combine
import core

protocol TransactionHistoryPresenterProtocol: AnyObject {
    var interactor: TransactionHistoryInteractorProtocol { get }

    var router: TransactionHistoryRouterProtocol? { get set }
    var view: TransactionHistoryViewControllerProtocol? { get set }

    func getTransactionHistory()
}

class TransactionHistoryPresenter: TransactionHistoryPresenterProtocol {
    internal let interactor: TransactionHistoryInteractorProtocol
    
    weak var router: TransactionHistoryRouterProtocol?
    weak var view: TransactionHistoryViewControllerProtocol?
    
    let isFlashOn = CurrentValueSubject<Bool, Never>(false)
    
    init(
        interactor: TransactionHistoryInteractorProtocol
    ) {
        self.interactor = interactor
    }
    
    func getTransactionHistory()  {
        self.view?.update(with: self.interactor.getTransactionHistory())
    }
}
