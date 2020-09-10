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
    @IBOutlet weak var progressTextField: UITextField!
    @IBOutlet weak var timeintervalTextField: UITextField!
    
    private var backgroundLayer: CAShapeLayer?
    private var progressLayer: CAShapeLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let backgroundLayer = configureBackgroundLayer()
        barBackgroundView.layer.addSublayer(backgroundLayer)
        self.backgroundLayer = backgroundLayer
        
        let progressLayer = configureProgressLayer()
        barBackgroundView.layer.insertSublayer(progressLayer, above: backgroundLayer)
        self.progressLayer = progressLayer
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        backgroundLayer?.path = configureProgressBarPath()
        progressLayer?.path = configureProgressBarPath()
    }
    
    @IBAction func playAction(_ sender: Any) {
        guard let progress = Int(progressTextField.text ?? "0"),
            let interval = Int(timeintervalTextField.text ?? "0") else { return }
        startAnimation(score: progress, duration: TimeInterval(interval))
    }
    
    @IBAction func stopAction(_ sender: UIButton) {
        resetProgressBar()
    }
    

    private func configureBackgroundLayer() -> CAShapeLayer {
        let backgroundLayer = CAShapeLayer()
        
        backgroundLayer.path = configureProgressBarPath()
        backgroundLayer.strokeColor = UIColor.lightGray.cgColor
        backgroundLayer.lineWidth = 8
        backgroundLayer.lineCap = .round
        backgroundLayer.fillColor = nil
        
        return backgroundLayer
    }
    
    private func configureProgressBarPath() -> CGPath {
        UIBezierPath(
            arcCenter: CGPoint(x: barBackgroundView.bounds.midX,
                               y: barBackgroundView.bounds.midY),
            radius: 96,
            startAngle: 3 * CGFloat.pi / 4,
            endAngle: CGFloat.pi / 4,
            clockwise: true
        ).cgPath
    }
    
    private func configureProgressLayer() -> CAShapeLayer{
        let progressLayer = CAShapeLayer()
        
        progressLayer.path = configureProgressBarPath()
        progressLayer.strokeColor = UIColor.green.cgColor
        progressLayer.lineWidth = 8
        progressLayer.lineCap = .round
        progressLayer.fillColor = nil
        progressLayer.strokeEnd = 0
        
        return progressLayer
    }
    
    private func resetProgressBar() {
        progressLayer?.strokeEnd = 0
        progressLayer?.removeAllAnimations()
    }
    
    private func startAnimation(score: Int, duration: TimeInterval) {
        resetProgressBar()
        
        let progress = CGFloat(score) / 100
        
        progressLayer?.strokeEnd = progress
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = progress
        strokeEndAnimation.duration = duration
        
        progressLayer?.add(strokeEndAnimation, forKey: "strokeEndAnimation")
    }

}


class GradientArcView: UIView {
    @IBInspectable var startColor: UIColor = .white { didSet { setNeedsLayout() } }
    @IBInspectable var endColor:   UIColor = .blue  { didSet { setNeedsLayout() } }
    @IBInspectable var lineWidth:  CGFloat = 3      { didSet { setNeedsLayout() } }

    private let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.type = .conic
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        return gradientLayer
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        configure()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        updateGradient()
    }
}

private extension GradientArcView {
    func configure() {
        layer.addSublayer(gradientLayer)
    }

    func updateGradient() {
        gradientLayer.frame = bounds
        gradientLayer.colors = [startColor, endColor].map { $0.cgColor }

        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = (min(bounds.width, bounds.height) - lineWidth) / 2
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        let mask = CAShapeLayer()
        mask.fillColor = UIColor.clear.cgColor
        mask.strokeColor = UIColor.white.cgColor
        mask.lineWidth = lineWidth
        mask.path = path.cgPath
        gradientLayer.mask = mask
    }
}
