//
//  CircleProgressBarViewController.swift
//  Animations
//
//  Created by  Matvey on 06.09.2020.
//  Copyright © 2020 Borisov Matvei. All rights reserved.
//

import UIKit

class CircleProgressBarViewController: UIViewController {

    @IBOutlet weak var barBackgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    private func configureBackgroundLayer() -> CAShapeLayer {
        let backgroundLayer = CAShapeLayer()
        
        return backgroundLayer
    }

}
