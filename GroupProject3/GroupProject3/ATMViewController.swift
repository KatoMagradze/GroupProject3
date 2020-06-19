//
//  ATMViewController.swift
//  GroupProject3
//
//  Created by Kato on 6/19/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

class ATMViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var languageButton: UIButton!
    
    
    var atms = [Object]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.getAPI()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func LanguageTapped(_ sender: UIButton) {
        self.alert()
    }
    
    func alert(){
       let actionSheet = UIAlertController(title: "Change Language", message: "choose language", preferredStyle: .actionSheet)
       let GeAction = UIAlertAction(title: "georgian", style: .default) { UIAlertAction in
             print("ge")
           }
       let EnAction = UIAlertAction(title: "English", style: .default) { UIAlertAction in
         print("en")
       }
       let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
       actionSheet.addAction(GeAction)
       actionSheet.addAction(EnAction)
       actionSheet.addAction(cancel)
       self.present(actionSheet, animated: true)
     }

    func getAPI(){
        APIServices.decode(file: "https://run.mocky.io/v3/96016c7a-9b7a-4b7a-997e-3ebc860516a5"){ (res) in
            
            let list = res.objects
            for object in list {
                if object.objectTypeID == "1"
                {
                    self.atms.append(object)
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            print(self.atms)
        }
    }
    
}
extension ATMViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return atms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "atm_cell", for: indexPath) as! ATMCell
        
        cell.atmNameLabel.text = atms[indexPath.row].nameGe
        cell.atmAddress.text = atms[indexPath.row].addressGe
        
        return cell
    }
    
    
}
