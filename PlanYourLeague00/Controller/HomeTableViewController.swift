//
//  HomeTableViewController.swift
//  PlanYourLeague00
//
//  Created by Myung Woo on 9/8/24.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    @IBOutlet var homeEmptyView: UIView!
    var games: [Game] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Prepare the empty view
        tableView.backgroundView = homeEmptyView
        tableView.backgroundView?.isHidden = games.count == 0 ? false : true

        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Navigation
        navigationController?.navigationBar.prefersLargeTitles = true
        // Walkthrough
        if UserDefaults.standard.bool(forKey: "walkthroughDone"){
            return
        }
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let walkthroughViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughViewController") as? WalkthroughViewController {
            print("minhvu")
            present(walkthroughViewController, animated: true, completion: nil)
        }
    }
    
    func homeConfigureDataSource() -> GameDiffableDataSource{
        let cellIdentifier = "datacell"
        let dataSource = GameDiffableDataSource(
            tableView: tableView,
            cellProvider: {tableView, indexPath, game in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HomeTableViewCell
                cell.leagueNameLabel.text = game.leagueName
                cell.dateLabel.text = game.date
                cell.team1GoalLabel.text = String(game.team1Goal)
                cell.team1NameLabel.text = game.team1Name
                cell.team1logo.image = UIImage(data: game.team1Logo)
                cell.team2GoalLabel.text = String(game.team2Goal)
                cell.team2NameLabel.text = game.team2Name
                cell.team2Logo.image = UIImage(data: game.team2Logo)
                
                return cell
            }
        )
        return dataSource
    }

}

