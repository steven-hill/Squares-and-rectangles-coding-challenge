//
//  ViewController.swift
//  SquaresAndRectanglesCodingChallenge
//
//  Created by Steven Hill on 11/09/2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Shapes.
    let redView = Shape(backgroundColor: .systemRed)
    let blueView = Shape(backgroundColor: .systemBlue)
    let whiteView = Shape(backgroundColor: .white)
    let purpleView = Shape(backgroundColor: .systemPurple)
    
    // MARK: - Labels.
    let redViewLabel = ShapeLabel(textAlignment: .left, fontSize: 17, textColor: .black, text: "Red Square\n(170x170)", numberOfLines: 2)
    let blueViewLabel = ShapeLabel(textAlignment: .right, fontSize: 17, textColor: .black, text: "Blue\nSquare\n(120x120)", numberOfLines: 3)
    let whiteViewLabel = ShapeLabel(textAlignment: .center, fontSize: 17, textColor: .black, text: "White Rectangle (20 offset)", numberOfLines: 3)
    let purpleViewLabel = ShapeLabel(textAlignment: .center, fontSize: 11, textColor: .black, text: "Purple Rectangle", numberOfLines: 2)
    var timerLabel = TimerLabel(textAlignment: .center, fontSize: 24, weight: .regular, textColor: .white, text: "", numberOfLines: 1)
    
    // MARK: - References to constraints
    
    var purpleViewLeading: NSLayoutConstraint?
    var purpleViewTrailing: NSLayoutConstraint?
    var purpleViewHeight: NSLayoutConstraint?
    var purpleViewBottom: NSLayoutConstraint?
    
    var whiteViewLeading: NSLayoutConstraint?
    var whiteViewTrailing: NSLayoutConstraint?
    var whiteViewTop: NSLayoutConstraint?
    var whiteViewBottom: NSLayoutConstraint?
    
    var whiteViewLabelCenterX: NSLayoutConstraint?
    var whiteViewLabelCenterY: NSLayoutConstraint?
    var whiteViewLabelHeight: NSLayoutConstraint?
    var whiteViewLabelWidth: NSLayoutConstraint?
    
    var purpleViewLabelCenterX: NSLayoutConstraint?
    var purpleViewLabelCenterY: NSLayoutConstraint?
    var purpleViewLabelHeight: NSLayoutConstraint?
    var purpleViewLabelWidth: NSLayoutConstraint?
    
    // MARK: - Track if either rectangle was tapped
    
    var wasWhiteOrPurpleTapped: Bool = false
    
    // MARK: - Timer
    
    var timer = Timer()
    var count: Double = 0.0
    
    // MARK: - viewDidLoad().
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Views.
        view.backgroundColor = .black
        view.addSubview(whiteView)
        view.addSubview(purpleView)
        view.addSubview(redView)
        view.addSubview(blueView)
        view.addSubview(redViewLabel)
        view.addSubview(blueViewLabel)
        view.addSubview(whiteViewLabel)
        view.addSubview(purpleViewLabel)
        view.addSubview(timerLabel)
        
        // Constraints.
        layoutWhiteViewConstraints(leading: 20, trailing: -20, top: 190, bottom: -140)
        layoutRedViewAndBlueViewConstraints()
        applyOrientationConstraints()
        layoutRedViewLabelConstraints()
        layoutBlueViewLabelConstraints()
        layoutTimerLabelConstraints()
        
        // Tap gesture.
        setupTapGesture()
    }
    
    // MARK: - Timer methods.
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        runTimer()
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(updateTimerUI), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimerUI() {
        count = count + 0.001
        let time = stringFromTimeInterval(interval: count)
        timerLabel.text = time
    }
    
    func stringFromTimeInterval(interval: Double) -> String {
        let hours = Int((interval / 3600))
        let minutes = Int((interval / 60).truncatingRemainder(dividingBy: 60))
        let seconds = Int(interval.truncatingRemainder(dividingBy: 60))
        let ms = Int((interval.truncatingRemainder(dividingBy: 1)) * 1000)
        return String(format: "%0.2d:%0.2d:%0.2d.%0.3d", hours, minutes, seconds, ms)
    }
    
    // MARK: - Tap methods.
    
    func setupTapGesture() {
        let whiteViewTapped = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.whiteView.addGestureRecognizer(whiteViewTapped)
        
        let purpleViewTapped = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.purpleView.addGestureRecognizer(purpleViewTapped)
    }
    
    @objc func handleTap() {
        wasWhiteOrPurpleTapped = true
        count = 0
        
        layoutWhiteViewConstraints(leading: 170, trailing: -120, top: 190, bottom: -140)
        layoutPurpleViewConstraints(leading: 190, trailing: -140, bottom: -20, height: 0.35)
        
        layoutWhiteViewLabelConstraintsAfterTap()
        layoutPurpleViewLabelConstraintsAfterTap()
    }
    
    // MARK: - Methods to lay out the views' constraints.
    
    func layoutRedViewAndBlueViewConstraints() {
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            redView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            redView.widthAnchor.constraint(equalToConstant: 170),
            redView.heightAnchor.constraint(equalToConstant: 170),
            
            blueView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            blueView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            blueView.heightAnchor.constraint(equalToConstant: 120),
            blueView.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func layoutWhiteViewConstraints(leading: Double, trailing: Double, top: Double, bottom: CGFloat) {
        whiteViewLeading?.isActive = false
        whiteViewTrailing?.isActive = false
        whiteViewTop?.isActive = false
        whiteViewBottom?.isActive = false
        
        whiteViewLeading = whiteView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: leading)
        whiteViewTrailing = whiteView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: trailing)
        whiteViewTop = whiteView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: top)
        whiteViewBottom = whiteView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: bottom)
        
        whiteViewLeading?.isActive = true
        whiteViewTrailing?.isActive = true
        whiteViewTop?.isActive = true
        whiteViewBottom?.isActive = true
    }
    
    func layoutPurpleViewConstraints(leading: Double, trailing: Double, bottom: Double, height: CGFloat) {
        purpleViewLeading?.isActive = false
        purpleViewTrailing?.isActive = false
        purpleViewBottom?.isActive = false
        purpleViewHeight?.isActive = false
        
        purpleViewLeading = purpleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: leading)
        purpleViewTrailing = purpleView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: trailing)
        purpleViewBottom = purpleView.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: bottom)
        purpleViewHeight = purpleView.heightAnchor.constraint(equalTo: whiteView.heightAnchor, multiplier: height)
        
        purpleViewLeading?.isActive = true
        purpleViewTrailing?.isActive = true
        purpleViewBottom?.isActive = true
        purpleViewHeight?.isActive = true
    }
    
    func applyOrientationConstraints() {
        if UIDevice.current.orientation.isLandscape {
            purpleViewLeading?.isActive = false
            purpleViewTrailing?.isActive = false
            purpleViewBottom?.isActive = false
            purpleViewHeight?.isActive = false
            purpleView.isHidden = true
            
            whiteViewLabelCenterX?.isActive = false
            whiteViewLabelCenterY?.isActive = false
            whiteViewLabelWidth?.isActive = false
            whiteViewLabelHeight?.isActive = false
            whiteViewLabel.isHidden = true
            
            purpleViewLabelCenterX?.isActive = false
            purpleViewLabelCenterY?.isActive = false
            purpleViewLabelWidth?.isActive = false
            purpleViewLabelHeight?.isActive = false
            purpleViewLabel.isHidden = true
        } else if UIDevice.current.orientation.isPortrait && wasWhiteOrPurpleTapped {
            purpleView.isHidden = false
            layoutPurpleViewConstraints(leading: 190, trailing: -140, bottom: -20, height: 0.35)
            
            whiteViewLabel.isHidden = false
            layoutWhiteViewLabelConstraintsAfterTap()
            
            purpleViewLabel.isHidden = false
            layoutPurpleViewLabelConstraintsAfterTap()
        } else {
            // Portrait and before tap.
            layoutPurpleViewConstraints(leading: 40, trailing: -40, bottom: -20, height: 0.35)
            layoutWhiteViewLabelConstraintsBeforeTap()
            layoutPurpleViewLabelConstraintsBeforeTap()
            purpleView.isHidden = false
            whiteViewLabel.isHidden = false
            purpleViewLabel.isHidden = false
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        applyOrientationConstraints()
    }
    
    // MARK: - Methods to lay out the labels' constraints.
    
    func layoutRedViewLabelConstraints() {
        NSLayoutConstraint.activate([
            redViewLabel.centerXAnchor.constraint(equalTo: redView.centerXAnchor),
            redViewLabel.centerYAnchor.constraint(equalTo: redView.centerYAnchor),
            redViewLabel.heightAnchor.constraint(equalToConstant: 60),
            redViewLabel.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func layoutBlueViewLabelConstraints() {
        NSLayoutConstraint.activate([
            blueViewLabel.centerXAnchor.constraint(equalTo: blueView.centerXAnchor),
            blueViewLabel.centerYAnchor.constraint(equalTo: blueView.centerYAnchor),
            blueViewLabel.heightAnchor.constraint(equalToConstant: 70),
            blueViewLabel.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func layoutWhiteViewLabelConstraintsBeforeTap() {
        whiteViewLabelCenterX?.isActive = false
        whiteViewLabelCenterY?.isActive = false
        whiteViewLabelHeight?.isActive = false
        whiteViewLabelWidth?.isActive = false
        
        whiteViewLabelCenterX = whiteViewLabel.centerXAnchor.constraint(equalTo: whiteView.centerXAnchor)
        whiteViewLabelCenterY = whiteViewLabel.centerYAnchor.constraint(equalTo: whiteView.centerYAnchor)
        whiteViewLabelHeight = whiteViewLabel.heightAnchor.constraint(equalToConstant: 70)
        whiteViewLabelWidth = whiteViewLabel.widthAnchor.constraint(equalToConstant: 250)
        
        whiteViewLabelCenterX?.isActive = true
        whiteViewLabelCenterY?.isActive = true
        whiteViewLabelHeight?.isActive = true
        whiteViewLabelWidth?.isActive = true
    }
    
    func layoutWhiteViewLabelConstraintsAfterTap() {
        whiteViewLabelCenterX?.isActive = false
        whiteViewLabelCenterY?.isActive = false
        whiteViewLabelHeight?.isActive = false
        whiteViewLabelWidth?.isActive = false
        
        whiteViewLabelCenterX = whiteViewLabel.centerXAnchor.constraint(equalTo: whiteView.centerXAnchor)
        whiteViewLabelCenterY = whiteViewLabel.centerYAnchor.constraint(equalTo: whiteView.centerYAnchor)
        whiteViewLabelHeight = whiteViewLabel.heightAnchor.constraint(equalToConstant: 70)
        whiteViewLabelWidth = whiteViewLabel.widthAnchor.constraint(equalToConstant: 100)
        
        whiteViewLabelCenterX?.isActive = true
        whiteViewLabelCenterY?.isActive = true
        whiteViewLabelHeight?.isActive = true
        whiteViewLabelWidth?.isActive = true
        
        whiteViewLabel.text = "White\nRectangle\n(20 offset)"
    }
    
    func layoutPurpleViewLabelConstraintsBeforeTap() {
        purpleViewLabelCenterX?.isActive = false
        purpleViewLabelCenterY?.isActive = false
        purpleViewLabelHeight?.isActive = false
        purpleViewLabelWidth?.isActive = false
        
        purpleViewLabelCenterX = purpleViewLabel.centerXAnchor.constraint(equalTo: purpleView.centerXAnchor)
        purpleViewLabelCenterY = purpleViewLabel.centerYAnchor.constraint(equalTo: purpleView.centerYAnchor)
        purpleViewLabelHeight = purpleViewLabel.heightAnchor.constraint(equalToConstant: 15)
        purpleViewLabelWidth = purpleViewLabel.widthAnchor.constraint(equalToConstant: 100)
        
        purpleViewLabelCenterX?.isActive = true
        purpleViewLabelCenterY?.isActive = true
        purpleViewLabelHeight?.isActive = true
        purpleViewLabelWidth?.isActive = true
    }
    
    func layoutPurpleViewLabelConstraintsAfterTap() {
        purpleViewLabelCenterX?.isActive = false
        purpleViewLabelCenterY?.isActive = false
        purpleViewLabelHeight?.isActive = false
        purpleViewLabelWidth?.isActive = false
        
        purpleViewLabelCenterX = purpleViewLabel.centerXAnchor.constraint(equalTo: purpleView.centerXAnchor)
        purpleViewLabelCenterY = purpleViewLabel.centerYAnchor.constraint(equalTo: purpleView.centerYAnchor)
        purpleViewLabelHeight = purpleViewLabel.heightAnchor.constraint(equalToConstant: 30)
        purpleViewLabelWidth = purpleViewLabel.widthAnchor.constraint(equalToConstant: 60)
        
        purpleViewLabelCenterX?.isActive = true
        purpleViewLabelCenterY?.isActive = true
        purpleViewLabelHeight?.isActive = true
        purpleViewLabelWidth?.isActive = true
        
        purpleViewLabel.text = "Purple\nRectangle"
    }
    
    func layoutTimerLabelConstraints() {
        NSLayoutConstraint.activate([
            timerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            timerLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            timerLabel.widthAnchor.constraint(equalToConstant: 200),
            timerLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
