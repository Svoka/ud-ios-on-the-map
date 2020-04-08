//
//  GeoCodingResultViewController.swift
//  OnTheMap
//
//  Created by Artem Osipov on 07/04/2020.
//  Copyright © 2020 Artem Osipov. All rights reserved.
//

import UIKit
import MapKit

class GeoCodingResultViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var preloader: UIActivityIndicatorView!
    @IBOutlet weak var submitButton: UIButton!
    
    var location: CLLocationCoordinate2D?
    var mapString: String?
    var link: String?
    
    var apiClient : ApiClient  {
       let object = UIApplication.shared.delegate
       let appDelegate = object as! AppDelegate
       return appDelegate.apiClient
   }
    
    var student: Student! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.student
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let annotation = MKPointAnnotation()
        annotation.coordinate = location!
        mapView.addAnnotation(annotation)
        mapView.setCenter(location!, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        togglePreloader(isVisible: false)
    }
    

    
    func togglePreloader(isVisible: Bool) {
        preloader.isHidden = !isVisible
        submitButton.isEnabled = !isVisible
    }
    
    @IBAction func finishTapped(_ sender: Any) {
        togglePreloader(isVisible: true)
        
        let studentLocation = StudentLocation(firstName: student.firstName, lastName: student.lastName, longitude: location!.longitude, latitude: location!.latitude, mapString: mapString ?? "", mediaURL: link!, uniqueKey: student.key)
        apiClient.postLocation(location: studentLocation, result: { (response, error) in
            DispatchQueue.main.async {
                self.togglePreloader(isVisible: false)
                if error != nil {
                    Utils.showAlert(alertMessage: self.apiClient.getAlertDataFromError(error: error!), buttonTitle: "Ok", presenter: self)
                    return
                }
                self.navigationController?.dismiss(animated: true, completion: nil)
            }
        })
    }
}
