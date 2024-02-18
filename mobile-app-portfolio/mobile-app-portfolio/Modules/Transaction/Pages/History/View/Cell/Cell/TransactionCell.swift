//
//  TransactionCell.swift
//  mobile-app-portfolio
//
//  Created by Muhammad Fachri Nuriza on 18/02/24.
//

import UIKit
import core

class TransactionCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var nominal: UILabel!
    
    static let cellIdentifier = "TransactionCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with data: Transaction) {
        date.text = DateTime.getDateStringFromDashedDateString(string: data.trx_date)
        nominal.text = "\(data.nominal.f(.currency))"
    }
}
