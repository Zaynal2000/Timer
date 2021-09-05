//
//  ViewController.swift
//  Timer
//
//  Created by Зайнал Гереев on 02.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    
    let addButton : UIButton = {
        let button = UIButton()
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var textFieldName = UITextField()
    var textFielTime = UITextField()
    
    var tableView = UITableView()
    let indentifier = "Cell"
    var timerList: [MyTimer] = []
    var sortedTimerList: [MyTimer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton.addTarget(self, action: #selector(didAppendTimer), for: .touchUpInside)
        
        view.backgroundColor = .white
        
        textFieldName.delegate = self
        
        createTextFields()
        setContstaints()
        createTable()
        
        
    }
    
    
    
    
    private func setContstaints() {
        
        view.addSubview(addButton)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 20),
            
            tableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
            
        ])
    }
    
    //MARK: - Create TextFields
    func createTextFields() {
        
        
        let textFieldTimeFrame = CGRect(x: 20, y: 140, width: 200, height: 31)
        
        textFielTime = UITextField(frame: textFieldTimeFrame)
        textFielTime.borderStyle = .roundedRect
        textFielTime.contentVerticalAlignment = .center
        textFielTime.textAlignment = .center
        textFielTime.placeholder = "Время в секундах"
        view.addSubview(textFielTime)
        
        
        
        let textFieldNameFrame = CGRect(x: 20, y: 100, width: 200, height: 31)
        textFieldName = UITextField(frame: textFieldNameFrame)
        textFieldName.borderStyle = .roundedRect
        textFieldName.contentVerticalAlignment = .center
        textFieldName.textAlignment = .center
        textFieldName.placeholder = "Название таймера"
        view.addSubview(textFieldName)
    }
    
    func updateRow(index: Int ) {
        let indexPath = IndexPath(item: index, section: 0)
        tableView.reloadRows(at: [indexPath], with: .top)
    }
    
    //MARK: - Create TableView
    func createTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: indentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.setEditing(true, animated: true)
        
    }
    
    func sortTimerList() {
        var i = 0
        while i <= self.timerList.count-1 {
            self.timerList[i].index = i
            i += 1
        }
    }
    
    
    		
    @objc private func didAppendTimer() {
        DispatchQueue.main.async {
            let nameValue = self.textFieldName.text ?? ""
            let timeValue = Int(self.textFielTime.text ?? "0")!
            let newTimer = MyTimer(name: nameValue, time: timeValue, index: self.timerList.count, viewController: self)
            
            
            self.timerList.append(newTimer)
            self.timerList = self.timerList.sorted(by: {$0.time > $1.time})
            
            self.sortTimerList()
            
            
            self.tableView.reloadData()
        }
        
    }
}








//MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    
    //    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    //        //хочу сделать разрешение редактиорвания только когда стринг - для названия, и только инт - для времени
    //
    //        return true
    //    }
}

//MARK: - UITableViewDataSource & UITableViewDelegate

extension ViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: indentifier, for: indexPath)
        
        
        
        var content = cell.defaultContentConfiguration()
        //content.text = timerList[indexPath.row].name
        content.text = "\(timerList[indexPath.row].name)                                                 \(timerList[indexPath.row].timeLabel)"
        //content.secondaryText = timerList[indexPath.row].time
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    
    private func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}


