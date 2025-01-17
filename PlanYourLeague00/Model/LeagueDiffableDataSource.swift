//
//  LeagueDiffableDataSource.swift
//  PlanYourLeague00
//
//  Created by Myung Woo on 8/28/24.
//

import UIKit

enum Section{
    case all
}

class LeagueDiffableDataSource: UITableViewDiffableDataSource<Section, League> {

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
