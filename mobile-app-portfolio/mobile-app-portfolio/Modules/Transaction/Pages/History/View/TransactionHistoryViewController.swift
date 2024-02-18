//
//  TransactionHistoryViewController.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import UIKit
import core

protocol TransactionHistoryViewControllerProtocol where Self: UIViewController {
    var presenter: TransactionHistoryPresenterProtocol { get }
    var router: TransactionHistoryRouterProtocol { get }
    
    func update(with history: [DonutChart])
}

class TransactionHistoryViewController: BaseViewController, TransactionHistoryViewControllerProtocol {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var emptyState: CustomUIView!
    @IBOutlet weak var emptyImage: UIImageView!
    
    var presenter: TransactionHistoryPresenterProtocol
    var router: TransactionHistoryRouterProtocol
    
    var history: [DonutChart]?
    
    init(
        presenter: TransactionHistoryPresenterProtocol,
        router: TransactionHistoryRouterProtocol
    ) {
        self.presenter = presenter
        self.router = router

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.setNavigationBarWithTitle(title: "History Transaksi")
        loadData()
    }
    
    func setupUI() {
        collectionView.isScrollEnabled = true
        collectionView.allowsSelection = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: HistoryCell.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: HistoryCell.cellIdentifier)
        
        self.emptyImage.image = UIImage(named: "ic_empty", in: Bundle(identifier: CoreBundle.getIdentifier()), compatibleWith: nil)
        
    }
    
    func loadData() {
        self.presenter.getTransactionHistory()
    }
    
    func update(with history: [DonutChart]) {
        self.history = history
        if history.count > 0 {
            self.collectionView.isHidden = false
            self.collectionView.reloadData()
            self.emptyState.isHidden = true
        } else {
            self.collectionView.isHidden = true
            self.emptyState.isHidden = false
        }
    }
}

extension TransactionHistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return history?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCell.cellIdentifier, for: indexPath) as! HistoryCell
        let data = history![indexPath.row]
        cell.update(with: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: collectionView.frame.width,
            height: 200
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = history![indexPath.row]
        self.router.presentTransactionDetail(with: data)
    }
}


