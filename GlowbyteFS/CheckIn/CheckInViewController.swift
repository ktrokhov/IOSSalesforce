//
//  CheckInViewController.swift
//  GlowbyteFS
//
//  Created by Kirill on 02.12.2019.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit

class CheckInViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func CheckOutButton(_ sender: Any) {
        print("CheckOut")
//        guard let vc = storyboard?.instantiateViewController(identifier: "NewClaimViewController") as? NewClaimViewController else { return }
//            navigationController?.viewControllers = [vc];(vc, animated: true)
        }
    @IBAction func MapButton(_ sender: Any) {
        print("Map")
//        guard let vc = storyboard?.instantiateViewController(identifier: "RouteToDestination") as? RouteToDestination else { return }
//            navigationController?.viewControllers = [vc];(vc, animated: true)
    }
    @IBAction func GoogleMapButton(_ sender: Any) {
        let testURL = URL(string: "comgooglemaps-x-callback://")!
        if UIApplication.shared.canOpenURL(testURL) {
          let directionsRequest = "comgooglemaps-x-callback://" +
            "?daddr=John+F.+Kennedy+International+Airport,+Van+Wyck+Expressway,+Jamaica,+New+York" +
            "&x-success=sourceapp://?resume=true&x-source=AirApp"

          let directionsURL = URL(string: directionsRequest)!
          UIApplication.shared.openURL(directionsURL)
        } else {
          NSLog("Can't use comgooglemaps-x-callback:// on this device.")
        }
//        guard let vc = storyboard?.instantiateViewController(identifier: "GoogleMapViewController") as? GoogleMapViewController else { return }
//        navigationController?.viewControllers = [vc];(vc, animated: true)
    }
    
}


