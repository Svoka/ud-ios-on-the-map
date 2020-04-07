//
//  LocationTableViewController.swift
//  OnTheMap
//
//  Created by Artem Osipov on 07/04/2020.
//  Copyright © 2020 Artem Osipov. All rights reserved.
//

import UIKit

class LocationTableViewController: UITableViewController {
    
    var apiClient : ApiClient  {
           let object = UIApplication.shared.delegate
           let appDelegate = object as! AppDelegate
           return appDelegate.apiClient
       }
    
    var locations: [StudentLocation]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.studentLocations
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return locations.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell")!
        let location = locations[indexPath.row]
        
        cell.textLabel?.text = "\(location.firstName) \(location.lastName)"
        cell.detailTextLabel?.text = location.mediaURL
        cell.imageView!.image = UIImage(named: "icon_pin")

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let app = UIApplication.shared
        
        let location = locations[indexPath.row]
        app.open(URL(string: location.mediaURL)!)
        
    }
    
    func loadLocations() {
        
        apiClient.loadLocations(result: {locationResult, error in
            if error != nil {
                DispatchQueue.main.async {
                    Utils.showAlert(alertMessage: self.apiClient.getAlertDataFromError(error: error!), buttonTitle: "Ok", presenter: self)
                }
                return
            }
            
            DispatchQueue.main.async {
                let object = UIApplication.shared.delegate
                let appDelegate = object as! AppDelegate
                appDelegate.studentLocations.removeAll()
                appDelegate.studentLocations.append(contentsOf: locationResult!.results)
                
                self.tableView.reloadData()
            }
            
        })
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func reloadTapped(_ sender: Any) {
        loadLocations()
    }
    
    
    @IBAction func addTapped(_ sender: Any) {
        let detailController = storyboard?.instantiateViewController(withIdentifier: "addPlaceController") as! UINavigationController
        detailController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        navigationController?.showDetailViewController(detailController, sender: self)
    }

}
