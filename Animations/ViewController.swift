//
//  ViewController.swift
//  Animations
//
//  Created by  Matvey on 05.09.2020.
//  Copyright © 2020 Borisov Matvei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellId = String(describing: CustomTableViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        
        registerXibCell()
    }
    
    
    private func registerXibCell() {
        let nibCell = UINib(nibName: cellId, bundle: nil)
        
        tableView.register(nibCell, forCellReuseIdentifier: cellId)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CustomTableViewCell {
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}