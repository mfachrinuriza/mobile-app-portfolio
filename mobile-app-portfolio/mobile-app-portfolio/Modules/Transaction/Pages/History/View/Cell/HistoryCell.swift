//
//  HistoryCell.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 14/02/24.
//

import UIKit
import core

class HistoryCell: UICollectionViewCell {

    @IBOutlet weak var merchantImage: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    static let cellIdentifier = "HistoryCell"
    
    var trx: [Transaction]? = nil {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        merchantImage.layer.cornerRadius = merchantImage.frame.width / 2
        
        tableView.allowsSelection = false 
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: TransactionCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: TransactionCell.cellIdentifier)
    }
    
    func update(with donoutChart: DonutChart) {
        self.label.text = donoutChart.label
        self.trx = donoutChart.data
    }
}

extension HistoryCell: UITableViewDelegate, UITableViewDataSource  {
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
