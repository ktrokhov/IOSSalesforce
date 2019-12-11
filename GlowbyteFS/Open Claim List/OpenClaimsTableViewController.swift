//
//  OpenClaimsTableViewController.swift
//  Redwoods Insurance Project
//
//  Created by Kevin Poorman on 11/9/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import UIKit
import SalesforceSDKCore
import SmartStore
import SmartSync

 
 var   ourID: String?

class OpenClaimsTableViewController: UITableViewController {
    //пытаемся сделать офлайн режим

    /// Used by the storyboard to unwind other scenes back
    /// to this view controller.
    ///
    /// Fetches new data whenever a new claim is submitted.
    ///
    /// - Parameter segue: The segue to unwind.
    @IBAction func unwindFromNewClaim(segue: UIStoryboardSegue) {
//        if let newClaimViewController = segue.source as? NewClaimViewController {
//            if newClaimViewController.wasSubmitted {
//                dataSource.fetchData()
//            }
//        }
    }

    @IBAction func logout(_ sender: Any) {
        UserAccountManager.shared.logout()
    }

    private let dataSource = ObjectListDataSource(
        soqlQuery: "SELECT Id, Subject, CaseNumber FROM Case WHERE Status != 'Closed' ORDER BY CaseNumber DESC",
        cellReuseIdentifier: "CasePrototype") { record, cell in
        let subject = record["Subject"] as? String ?? ""
        let caseNumber = record["CaseNumber"] as? String ?? ""
        var caseNumberr = CaseNumber
            print(caseNumberr as Any)
        cell.textLabel?.text = subject
        cell.detailTextLabel?.text = "Case #: \(caseNumber)"
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        //фоновый цвет
        let image = UIImage(named: "Background")
        let imageView = UIImageView(image: image)
        tableView.backgroundView = imageView
        imageView.alpha = 0.2
        
        
        self.dataSource.delegate = self
        self.tableView.delegate = self
        self.tableView.activityIndicatorView.startAnimating()
        self.tableView.dataSource = self.dataSource
        self.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(
            self.dataSource,
            action: #selector(self.dataSource.fetchData),
            for: UIControl.Event.valueChanged)
        self.tableView.addSubview(refreshControl!)
        self.dataSource.fetchData()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewClaimDetails" {
            guard let destination = segue.destination as? ClaimDetailsTableViewController,
                let cell = sender as? UITableViewCell else {return}
            let indexPath = self.tableView.indexPath(for: cell)!
            if let claimId = self.dataSource.records[indexPath.row]["Id"] as? String {
                print(indexPath.row)
                destination.claimId = claimId
                ourID=claimId
                print(ourID)
            }
        }
//        var store = SmartStore.shared(withName: "Case")
//        print(store)
    }
    
   
}

extension OpenClaimsTableViewController: ObjectListDataSourceDelegate {
    //override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)
        //guard let vc = storyboard?.instantiateViewController(identifier: "NewClaimViewController") as? NewClaimViewController else { return }
        //navigationController?.pushViewController(vc, animated: true)
    //}
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        
    }
    
    func objectListDataSourceDidUpdateRecords(_ dataSource: ObjectListDataSource) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
            self.tableView.activityIndicatorView.stopAnimating()
        }
    }
    
    
}
