//
//  ViewController.swift
//  GrocceryList
//
//  Created by Logan Peterson on 7/1/23.
//

import UIKit
import FirebaseDatabase
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
   
    let dataBase = Database.database().reference()
    var itemsDestination : [String] = []
var number = 0
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
            
            self.dataBase.child("Items").child("itemsDestination\(number)").setValue("\(items)")
            number+=1
            
            
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsDestination.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = itemsDestination[indexPath.row]
        
        let mySwitch = UISwitch()
        mySwitch.addTarget(self, action: #selector(didChangeSwitch(_:)), for: .valueChanged)
        cell.accessoryView = mySwitch
        return cell
    }
    @objc func didChangeSwitch(_ sender: UISwitch) {
        if sender.isOn {
            print("item recieved")
        }else{
            print("item not found")
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            itemsDestination.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    
}
