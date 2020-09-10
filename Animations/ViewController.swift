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
    
    lazy var model = [#selector(openCircleBarVC)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        
        registerXibCell()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? CustomTableViewCell {
        }
    }
    
    
    private func registerXibCell() {
        let nibCell = UINib(nibName: cellId, bundle: nil)
        
        tableView.register(nibCell, forCellReuseIdentifier: cellId)
    }
    
    @objc private func openCircleBarVC() {
        let vcId = String(describing: CircleProgressBarViewController.self)
        let sb = UIStoryboard(name: vcId, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: vcId)
        self.present(vc, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CustomTableViewCell {
            cell.buttonView.addTarget(self, action: model[indexPath.row], for: .touchUpInside)
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}
