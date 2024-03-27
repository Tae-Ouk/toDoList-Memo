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
    
    
    
    @IBAction func addListButton(_ sender: Any) {
        let alertTitle = "할 일 추가"
        let addTitle = "추가"
        let cancelTitle = "취소"
        
        let addListAlert = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
        
        addListAlert.addTextField { textField in
            textField.placeholder = "할 일 입력"
        }

        let cancelButton = UIAlertAction(title: cancelTitle, style: .cancel)
        
        let addButton = UIAlertAction(title: addTitle, style: .default) { _ in
            if let textField = addListAlert.textFields?.first, let taskTitle = textField.text, !taskTitle.isEmpty {
                self.addTask(title: taskTitle)
            }
        }
        
        addListAlert.addAction(addButton)
        addListAlert.addAction(cancelButton)
        
        self.present(addListAlert, animated: true)
    }
    
    
    
    func addTask(title: String) {
        count += 1
        data.append((id: count, title: title, isCompleted: false))
        toDoListTable.reloadData()
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
        
        let taskStateSwitch = UISwitch()
        taskStateSwitch.isOn = item.isCompleted
        taskStateSwitch.addTarget(self, action: #selector(switchStateChanged(_:)), for: .valueChanged)

        cell.accessoryView = taskStateSwitch
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected: \(data[indexPath.row])")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    @objc func switchStateChanged(_ sender: UISwitch) {
        guard let cell = sender.superview as? UITableViewCell,
              let indexPath = toDoListTable.indexPath(for: cell),
              let taskTitle = cell.textLabel?.text
        else {
            return
        }
        
        data[indexPath.row].isCompleted = sender.isOn
        
        let attributedString = NSMutableAttributedString(string: taskTitle)
        if sender.isOn {
            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributedString.length))
        }
        cell.textLabel?.attributedText = attributedString
    }
}
