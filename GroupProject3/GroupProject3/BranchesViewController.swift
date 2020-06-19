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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    


}
extension BranchesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "atm_cell", for: indexPath) as! ATMCell
        
        return cell
    }
    
    
}
