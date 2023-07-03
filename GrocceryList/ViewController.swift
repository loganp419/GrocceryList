//
//  ViewController.swift
//  GrocceryList
//
//  Created by Logan Peterson on 7/1/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var itemsDestination = ["A","B","C"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    @IBAction func AddItem(_ sender: Any) {
    let alert = UIAlertController(title: "Add an Item", message: nil , preferredStyle: .alert)
        
        alert.addTextField { field in
            field.placeholder = "type here"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Accept", style: .default, handler: { [self] _ in
            let fields = alert.textFields
            let itemTextField = fields![0]
            let items = itemTextField.text!
           print(items)
            itemsDestination.append(items)
       print(itemsDestination)
            tableView.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)
   
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsDestination.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = itemsDestination[indexPath.row
        ]
        return cell
    }
}
