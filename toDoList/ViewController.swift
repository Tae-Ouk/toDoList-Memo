//
//  ViewController.swift
//  number BaseBall App
//
//  Created by TaeOuk Hwang on 3/20/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var toDoListTable: UITableView!
    
    var data: [(id: Int, title: String, isCompleted: Bool)] = []
    var count: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDoListTable.dataSource = self
        toDoListTable.delegate = self
        toDoListTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let item = data[indexPath.row]
        cell.textLabel?.text = item.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected: \(data[indexPath.row])")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
