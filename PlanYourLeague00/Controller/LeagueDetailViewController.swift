//
//  LeagueDetailViewController.swift
//  PlanYourLeague00
//
//  Created by Myung Woo on 9/11/24.
//

import UIKit

class LeagueDetailViewController: UIViewController {
    
    var league: League!
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.backButtonTitle = ""
        
        headerView.headerLabelView.leagueNameLabel.text = league.name
        headerView.headerLabelView.leagueManagerLabel.text = league.manager
        headerView.headerImageView.image = UIImage(data: league.image)
        
        tableView.separatorStyle = .none
        
    }
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: LeagueDetailHeaderView!
    
    
    
}

extension LeagueDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LeagueDetailContactCell.self), for: indexPath) as! LeagueDetailContactCell
            
            cell.phoneLabel.text = league.phone
            cell.emailLabel.text = league.email
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LeagueDetailDescriptionCell.self), for: indexPath) as! LeagueDetailDescriptionCell
            
            cell.descriptionLabel.text = league.describe
            
            return cell
        default:
            fatalError("Failed to instantiate the table cell for detail view controller!!")
        }
    }
}
