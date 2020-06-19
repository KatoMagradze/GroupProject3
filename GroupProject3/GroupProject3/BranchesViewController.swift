//
//  BranchesViewController.swift
//  GroupProject3
//
//  Created by Kato on 6/19/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

class BranchesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var atmList = [Object]()
    var lat: Double!
    var lon: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getAPI()
        
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, id == "map_2"{
            if let mapVC = segue.destination as? MapViewController {
                mapVC.lat = self.lat
                mapVC.lon = self.lon
            }
        }
    }
    
   
    
    func getAPI(){
        APIServices.decode(){ (res) in
            let list = res.objects
            for object in list {
                if object.objectTypeID == "2"{
                    self.atmList.append(object)
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        
            //print(self.atmList)
      }
    }
   
    


}
extension BranchesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return atmList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BranchesCell", for: indexPath) as! BranchesCell
        let atm = atmList[indexPath.row]
        cell.atmNameLabel.text = atm.nameEn
        cell.adressLabel.text = atm.addressEn
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.lat = Double(atmList[indexPath.row].latitude)
        self.lon = Double(atmList[indexPath.row].longtitude)
        
        performSegue(withIdentifier: "map_2", sender: self)
        
    }
 
}

