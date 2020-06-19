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
    var selectedLanguage = 0
    var name: String?
    var adress: String?
    var lat: Double?
    var lon: Double?
    
    
    var atms = [Object]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
       // print(atms)
        
        
        self.getAPI()
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, id == "map_1"{
            if let mapVC = segue.destination as? MapViewController {
                mapVC.lat = self.lat
                mapVC.lon = self.lon
            }
        }
    }
    
    @IBAction func LanguageTapped(_ sender: UIButton) {
        self.alert()
    }
    
    func alert(){
       let actionSheet = UIAlertController(title: "Change Language", message: "choose language", preferredStyle: .actionSheet)
       let GeAction = UIAlertAction(title: "georgian", style: .default) { UIAlertAction in
             print("ge")
        self.selectedLanguage = 1
        self.tableView.reloadData()
           }
       let EnAction = UIAlertAction(title: "English", style: .default) { UIAlertAction in
         print("en")
        self.selectedLanguage = 0
        self.tableView.reloadData()
       }
       let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
       actionSheet.addAction(GeAction)
       actionSheet.addAction(EnAction)
       actionSheet.addAction(cancel)
       self.present(actionSheet, animated: true)
     }

    func getAPI(){
        APIServices.decode(){ (res) in
            
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
            //print(self.atms)
        }
    }
    
}
extension ATMViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return atms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "atm_cell", for: indexPath) as! ATMCell
        if selectedLanguage == 0{
            name = atms[indexPath.row].nameEn
            adress = atms[indexPath.row].addressEn
        }else if selectedLanguage == 1{
            name = atms[indexPath.row].nameGe
            adress = atms[indexPath.row].addressGe
        }
        cell.atmNameLabel.text = name
        cell.atmAddress.text = adress
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.lat = Double(atms[indexPath.row].latitude)!
        self.lon = Double(atms[indexPath.row].longtitude)!
        
        performSegue(withIdentifier: "map_1", sender: self)
    }
    
    
}
