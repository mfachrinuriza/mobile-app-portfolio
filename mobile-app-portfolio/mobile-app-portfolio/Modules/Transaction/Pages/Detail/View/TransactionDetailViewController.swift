//
//  TransactionDetailViewController.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import UIKit
import core

protocol TransactionDetailViewControllerProtocol where Self: UIViewController {
    var presenter: TransactionDetailPresenterProtocol { get }
    var router: TransactionDetailRouterProtocol { get }
    
    var detail: DonutChart? { get set }
}

class TransactionDetailViewController: BaseViewController, TransactionDetailViewControllerProtocol {

    var detail: DonutChart?
    
    var trx: [Transaction]? = nil {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    internal let presenter: TransactionDetailPresenterProtocol
    internal let router: TransactionDetailRouterProtocol
    
    init(
        presenter: TransactionDetailPresenterProtocol,
        router: TransactionDetailRouterProtocol
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
        self.setupUI()
        self.update(with: self.detail!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.setNavigationBarWithoutTitle()
    }
    
    func setupUI() {
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: TransactionCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: TransactionCell.cellIdentifier)
    }
    
    func update(with detail: DonutChart) {
        self.label.text = detail.label
        self.trx = detail.data
    }
    
}

extension TransactionDetailViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trx?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionCell.cellIdentifier, for: indexPath) as! TransactionCell
        let data = trx![indexPath.row]
        cell.update(with: data)
        return cell
    }
}
