//
//  CustomCell.swift
//  RealmTest
//
//  Created by sopra on 11/11/2020.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var voteAverageLabel: UILabel!
    
    public func setLabels(title: String, voteAverage: Double){
        self.titleLabel.text = title
        self.voteAverageLabel.text = String(describing: voteAverage)
    }
}
