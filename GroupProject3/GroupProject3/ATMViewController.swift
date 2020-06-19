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
    
    //var api = APIServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
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
        let list = res
        print(list)
      }
    }
    
}
extension ATMViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "atm_cell", for: indexPath) as! ATMCell
        
        return cell
    }
    
    
}
