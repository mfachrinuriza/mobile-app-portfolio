//
//  FittedTableView.swift
//  core
//
//  Created by Muhammad Fachri Nuriza on 18/02/24.
//

import UIKit

public class FittedTableView: UITableView {
    public override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    public override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}

