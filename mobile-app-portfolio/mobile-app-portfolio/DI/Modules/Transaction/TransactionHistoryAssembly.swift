//
//  TransactionHistoryAssembly.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 14/02/24.
//

import Swinject
import SwinjectAutoregistration

class TransactionHistoryAssembly: Assembly {
    
    func assemble(container: Container) {
        container.autoregister(TransactionHistoryInteractorProtocol.self, initializer: TransactionHistoryInteractor.init)
        container.autoregister(TransactionHistoryRouterProtocol.self, initializer: TransactionHistoryRouter.init)
        container.autoregister(TransactionHistoryPresenterProtocol.self, initializer: TransactionHistoryPresenter.init)

        container.register(TransactionHistoryViewControllerProtocol.self) { r in
            let presenter = r.resolve(TransactionHistoryPresenterProtocol.self)!
            let router = r.resolve(TransactionHistoryRouterProtocol.self)!
            let view = TransactionHistoryViewController(
                presenter: presenter,
                router: router
            )
            
            presenter.view = view
            presenter.router = router
            router.view = view
            
            return view
        }

    }
}
