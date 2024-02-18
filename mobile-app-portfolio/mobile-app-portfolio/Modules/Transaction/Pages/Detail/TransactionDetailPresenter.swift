//
//  TransactionDetailPresenter.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 14/02/24.
//

import Foundation
import Combine

protocol TransactionDetailPresenterProtocol: AnyObject {
    var interactor: TransactionDetailInteractorProtocol { get }

    var router: TransactionDetailRouterProtocol? { get set }
    var view: TransactionDetailViewControllerProtocol? { get set }
}

class TransactionDetailPresenter: TransactionDetailPresenterProtocol {
    internal let interactor: TransactionDetailInteractorProtocol
    
    weak var router: TransactionDetailRouterProtocol?
    weak var view: TransactionDetailViewControllerProtocol?
    
    init(
        interactor: TransactionDetailInteractorProtocol
    ) {
        self.interactor = interactor
    }
}
