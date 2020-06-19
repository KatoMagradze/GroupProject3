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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getAPI()
    }
    
    func getAPI(){
        APIServices.decode(file: "https://run.mocky.io/v3/96016c7a-9b7a-4b7a-997e-3ebc860516a5"){ (res) in
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
        cell.atmAdressLabel.text = atm.addressEn
        return cell
    }
    
    
}
