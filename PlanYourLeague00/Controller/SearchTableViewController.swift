//
//  LeagueTableViewController.swift
//  PlanYourLeague00
//
//  Created by Myung Woo on 8/28/24.
//

import UIKit
import CoreData

class SearchTableViewController: UITableViewController {
    
    var leagues: [League] = []
    @IBOutlet var searchEmptyView: UIView!
    var searchController: UISearchController!
    
    // MARK: Setting screen display
    // first time
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchLeagueData()
        tableView.backgroundView = searchEmptyView
        tableView.backgroundView?.isHidden = leagues.count == 0 ? false : true
        
        navigationController?.hidesBarsOnSwipe = true
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .black
        tableView.tableHeaderView = searchController.searchBar
        //self.navigationItem.searchController = searchController
        
        
    }
    // first time and later
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: animated)
        tableView.backgroundView?.isHidden = leagues.count == 0 ? false : true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.backgroundView?.isHidden = leagues.count == 0 ? false : true
    }
    
    // MARK: Display new restaurant
    var fetchResultController: NSFetchedResultsController<League>!
    
    func fetchLeagueData(searchText: String = "") {
        // Fetch datafrom datastore
        let fetchRequest: NSFetchRequest<League> = League.fetchRequest()
        if !searchText.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "name CONTAINS[c] %@", searchText)
        }
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                updateSnapshot(animatingChange: searchText.isEmpty ? false : true)
            } catch {
                print(error)
            }
        }
    }
    
    func updateSnapshot(animatingChange: Bool = false) {
        if let fetchObjects = fetchResultController.fetchedObjects {
            leagues = fetchObjects
        }
        // Create a snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, League>()
        snapshot.appendSections([.all])
        snapshot.appendItems(leagues, toSection: .all)
        
        dataSource.apply(snapshot, animatingDifferences: animatingChange)
    }

    // MARK: ConfigureDataSource
    func configureDataSource() -> LeagueDiffableDataSource {
        let cellIdentifier = "datacell"
        
        let dataSource = LeagueDiffableDataSource(
            tableView: tableView,
            cellProvider: {tableView, indexPath, league in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ExistingLeagueTableViewCell
                cell.nameLabel.text = league.name
                cell.typeLabel.text = league.type
                cell.descibeLabel.text = league.describe
                //cell.managerLabel.text = league.manager
                //cell.contactLagel.text = league.contact
                //cell.summaryLabel.text = league.summary
                cell.thumbnailImageView.image = UIImage(data: league.image)
                return cell
            }
        )
        return dataSource
    }
    lazy var dataSource = configureDataSource()
      
    // MARK: closebutton -> comeback to this controller from another controller
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Trailing swipe to open navigation bar
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Disable while in search mode
        if searchController.isActive {
            return UISwipeActionsConfiguration()
        }
        // Get the selected league(row)
        guard let league = self.dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }
        
        // Delete Action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            (action, sourceView, completionHandler) in
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                // Delete the item
                context.delete(league)
                appDelegate.saveContext()
                // Update the snapshot
                self.updateSnapshot(animatingChange: true)
            }
        }
        deleteAction.backgroundColor = UIColor.systemRed
        deleteAction.image = UIImage(systemName: "trash")
        
        // Configure action as swipe action
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfiguration
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLeagueDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! LeagueDetailViewController
                destinationController.league = self.leagues[indexPath.row]
            }
        }
    }
    
}

extension SearchTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        updateSnapshot()
    }
}

extension SearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        fetchLeagueData(searchText: searchText)
    }
}
