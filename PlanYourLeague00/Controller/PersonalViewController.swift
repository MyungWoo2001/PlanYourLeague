//
//  PersonalViewController.swift
//  PlanYourLeague00
//
//  Created by Myung Woo on 9/19/24.
//

import UIKit

class PersonalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    let personalFunctions = ["Your League", "Favorite"]
    let personalFunctionsImage = ["perleague","perfavorite"]
    let appFunctions = ["Setting", "Help and Support"]
    let appFunctionsImage = ["persetting", "perhelpandsupport"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0: return 1
        case 1: return personalFunctions.count
        case 2: return appFunctions.count
        case 3: return 1
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellIdentifier = "personalcell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = "User"
            cell.imageView?.image = UIImage(named: "perthumbnailmale")
            cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        case 1:
            cell.textLabel?.text = personalFunctions[indexPath.row]
            cell.imageView?.image = UIImage(named: self.personalFunctionsImage[indexPath.row])
        case 2:
            cell.textLabel?.text = appFunctions[indexPath.row]
            cell.imageView?.image = UIImage(named: self.appFunctionsImage[indexPath.row])
        case 3:
            cell.textLabel?.text = "Log out"
            cell.imageView?.image = UIImage(named: "perlogout")
        default: break
        }

        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Kiểm tra nếu là hàng đầu tiên (row 0) của section đầu tiên (section 0)
        if indexPath.section == 0 && indexPath.row == 0 {
            return 64 // Chiều cao mong muốn cho hàng đầu tiên trong section 0
        }
        
        return 44 // Chiều cao mặc định cho các hàng khác
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 3 {
            return 100 // Tạo khoảng cách lớn ở section trước cell cần đẩy xuống dưới
        }
        return 0 // Chiều cao footer mặc định cho các section khác
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
        
        switch section {
        case 0: return ""
        case 1: return "Personal"
        case 2: return "Applicaton"
        case 3: return "Account"
        default: return ""
        }
    }
}
