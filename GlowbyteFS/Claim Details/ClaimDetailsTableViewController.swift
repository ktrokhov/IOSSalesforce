//
//  ClaimDetailsTableViewController.swift
//  GlowbyteFS
//
//  Created by Kirill on 02.12.2019.
//  Copyright © 2019 Kirill. All rights reserved.
//
import UIKit
import SalesforceSDKCore
var locAdr: String?
var locAdrValue: String?


class ClaimDetailsTableViewController: UITableViewController {
    //var locAdr: String?
    var claimId: String?
    var dataSource: ObjectLayoutDataSource!
    let reuseIdentifier = "CaseDetailPrototype"
    
    
//переход на новый view по кнопке
    @IBAction func test(_ sender: Any) {
        print("Hello")
        guard let vc = storyboard?.instantiateViewController(identifier: "CheckInViewController") as? CheckInViewController else { return }
        navigationController?.viewControllers = [vc];(vc, animated: true)
        }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //фоновый цвет
             let image = UIImage(named: "Background")
             let imageView = UIImageView(image: image)
             tableView.backgroundView = imageView
             imageView.alpha = 0.2
        
        
        if let caseId = claimId {
            
            self.dataSource = ObjectLayoutDataSource(
                objectType: "Case",
                objectId: caseId,
                cellReuseIdentifier: self.reuseIdentifier) { field, cell in
                guard
                    // swiftlint:disable:next identifier_name
                    let key = field.first?.key,
                    let value = field[key] as? String else {return}
                cell.textLabel?.text = key
                cell.detailTextLabel?.text = value
                        if key=="LocationAdress__c" {
                        print("!!!!!!!!!!")
                            locAdr=key
                            locAdrValue=value
                           // print(locAdr)
                           // print(locAdrValue)
                        }
            }
            self.dataSource.delegate = self
            self.tableView.delegate = self
            //Можем тыкать на поля
            self.tableView.allowsSelection = true
            
            self.tableView.activityIndicatorView.startAnimating()
            self.tableView.dataSource = dataSource
            self.refreshControl = UIRefreshControl()
            refreshControl?.addTarget(
                self.dataSource,
                action: #selector(self.dataSource.fetchData),
                for: UIControl.Event.valueChanged
            )
            self.tableView.addSubview(refreshControl!)
            self.dataSource.fetchData()
        }
        
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let value = dataSource.fields[indexPath.row]
        if value.first?.key == "LocationAdress__c" {
            guard let vc = storyboard?.instantiateViewController(identifier: "GoogleMapViewController") as? GoogleMapViewController else { return }
            navigationController?.pushViewController(vc, animated: true)
//            navigationController?.viewControllers = [vc];(vc, animated: true)
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ClaimDetailsTableViewController: ObjectLayoutDataSourceDelegate {
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//        print(locAdr)
//        guard let vc = storyboard?.instantiateViewController(identifier: "RouteToDestination") as? RouteToDestination else { return }
//        navigationController?.pushViewController(vc, animated: true)
//    }
    
    func objectLayoutDataSourceDidUpdateFields(_ dataSource: ObjectLayoutDataSource) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
            self.tableView.activityIndicatorView.stopAnimating()
        }
    }
}
