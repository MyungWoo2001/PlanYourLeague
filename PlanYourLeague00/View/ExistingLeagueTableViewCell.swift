//
//  ExistingLeagueTableViewCell.swift
//  PlanYourLeague00
//
//  Created by Myung Woo on 8/29/24.
//

import UIKit

class ExistingLeagueTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var descibeLabel: UILabel!
    //@IBOutlet var contactLagel: UILabel!
    //@IBOutlet var managerLabel: UILabel!
    //@IBOutlet var summaryLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView! {
        didSet {
            thumbnailImageView.layer.cornerRadius = 20.0
            thumbnailImageView.clipsToBounds = true
        }
    }
}

