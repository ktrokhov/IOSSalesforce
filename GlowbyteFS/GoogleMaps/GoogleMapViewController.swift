//
//  GoogleMapViewController.swift
//  GlowbyteFS
//
//  Created by Kirill on 02.12.2019.
//  Copyright © 2019 Kirill. All rights reserved.
//
import UIKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON
import Alamofire
import CoreLocation



    //var dataSource: ObjectLayoutDataSource!
    var destination: String?
    

    class GoogleMapViewController: UIViewController {
          @IBOutlet weak var mapView: GMSMapView!
         private let locationManager = CLLocationManager()
        
        override func viewDidLoad() {
            super.viewDidLoad()
                        locationManager.delegate = self //
            locationManager.requestWhenInUseAuthorization() //
        }
    //  override func loadView() {
//        destination=locAdrValue
//        //print(locAdr)
//        print(locAdrValue)
//        print(destination)
//
//
//        // Create a GMSCameraPosition that tells the map to display the
//        // coordinate -33.86,151.20 at zoom level 6.
//        let camera = GMSCameraPosition.camera(withLatitude: 55.759552, longitude: 37.665985, zoom: 10)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        view = mapView
//
//        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: 55.759552, longitude: 37.665985)
//        marker.title = "GlowByte"
//        marker.snippet = "Consulting"
//        marker.map = mapView
        //Here you need to set your origin and destination points and mode
//       let abc = NSURL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=locationManager&destination=destination&mode=driving")
//
//        let task = URLSession.shared.dataTask(with: NSURL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=locationManager&destination=destination&mode=driving")! as URL) { (data, response, error) -> Void in
//
//                    do {
//                        if data != nil {
//                            let dic = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as!  [String:AnyObject]
//        //                        print(dic)
//
//                            let status = dic["status"] as! String
//                            var routesArray:String!
//                            if status == "OK" {
//                                routesArray = (((dic["routes"]!as! [Any])[0] as! [String:Any])["overview_polyline"] as! [String:Any])["points"] as? String
//        //                            print("routesArray: \(String(describing: routesArray))")
//                            }
//
//                            DispatchQueue.main.async {
//                                let path = GMSPath.init(fromEncodedPath: routesArray!)
//                                let singleLine = GMSPolyline.init(path: path)
//                                singleLine.strokeWidth = 6.0
//                                singleLine.strokeColor = .blue
//                                singleLine.map = mapView
//                            }
//
//                        }
//                    } catch {
//                        print("Error")
//                    }
//                }
//
//        task.resume();
    
    }



//
//// MARK: - CLLocationManagerDelegate
//
extension GoogleMapViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    guard status == .authorizedWhenInUse else {
      return
    }
    locationManager.startUpdatingLocation()
      print(locAdrValue)
    mapView.isMyLocationEnabled = true
    mapView.settings.myLocationButton = true
  }


  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else {
        print(locations)
      return
    }


    mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)

    locationManager.stopUpdatingLocation()

  }
    
}
