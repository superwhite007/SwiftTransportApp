//
//  AddNewPassTableViewCell.swift
//  TransitFare
//
//  Created by ajaybeniwal203 on 27/1/16.
//  Copyright © 2016 ajaybeniwal203. All rights reserved.
//

import UIKit

class AddNewPassTableViewCell: UITableViewCell {

    @IBOutlet var cardTypeView: UIImageView!
    @IBOutlet var cardNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}