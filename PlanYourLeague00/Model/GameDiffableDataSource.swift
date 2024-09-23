//
//  GameDiffableDataSource.swift
//  PlanYourLeague00
//
//  Created by Myung Woo on 9/9/24.
//

import UIKit

class GameDiffableDataSource: UITableViewDiffableDataSource<Section, Game> {
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
