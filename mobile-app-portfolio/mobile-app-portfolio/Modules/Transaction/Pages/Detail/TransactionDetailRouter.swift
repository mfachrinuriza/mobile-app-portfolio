//
//  TransactionDetailRouter.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 14/02/24.
//

import Foundation

protocol TransactionDetailRouterProtocol: AnyObject {
    var view: TransactionDetailViewControllerProtocol? { get set }
}

class TransactionDetailRouter: TransactionDetailRouterProtocol {
    weak var view: TransactionDetailViewControllerProtocol?
    
}
