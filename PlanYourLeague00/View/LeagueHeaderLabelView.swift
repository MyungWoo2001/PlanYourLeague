//
//  LeagueHeaderLabelView.swift
//  PlanYourLeague00
//
//  Created by Myung Woo on 9/22/24.
//

import UIKit

class LeagueHeaderLabelView: UIView {

    @IBOutlet var leagueNameLabel: UILabel! {
        didSet {
            leagueNameLabel.numberOfLines = 2
        }
    }
    @IBOutlet var leagueManagerLabel: UILabel! {
        didSet {
            leagueManagerLabel.numberOfLines = 1
        }
    }
}
