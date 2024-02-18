//
//  TransactionDetailAssembly.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 14/02/24.
//

import Swinject
import SwinjectAutoregistration

class TransactionDetailAssembly: Assembly {
    
    func assemble(container: Container) {
        container.autoregister(TransactionDetailInteractorProtocol.self, initializer: TransactionDetailInteractor.init)
        container.autoregister(TransactionDetailRouterProtocol.self, initializer: TransactionDetailRouter.init)
        container.autoregister(TransactionDetailPresenterProtocol.self, initializer: TransactionDetailPresenter.init)

        container.register(TransactionDetailViewControllerProtocol.self) { r in
            let presenter = r.resolve(TransactionDetailPresenterProtocol.self)!
            let router = r.resolve(TransactionDetailRouterProtocol.self)!
            let view = TransactionDetailViewController(
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
