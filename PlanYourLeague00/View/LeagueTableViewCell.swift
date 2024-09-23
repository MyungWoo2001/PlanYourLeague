//
//  LeagueTableViewCell.swift
//  PlanYourLeague00
//
//  Created by Myung Woo on 8/28/24.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var pointLabel: UILabel!
    @IBOutlet var rankLabel: UILabel!
    @IBOutlet var logoImageView: UIImageView!{
        didSet {
            logoImageView.layer.cornerRadius = 10.0
            logoImageView.clipsToBounds = true
        }
    }

}
