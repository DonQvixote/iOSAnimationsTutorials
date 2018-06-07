//
//  ViewController.swift
//  Bahama
//
//  Created by 夏语诚 on 2018/4/23.
//  Copyright © 2018年 Banana. All rights reserved.
//

import UIKit

// A delay function
func delay(_ seconds: Double, completion: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

func tintBackgroundColor(layer: CALayer, toColor: UIColor) {
//    let tint = CABasicAnimation(keyPath: "backgroundColor")
    let tint = CASpringAnimation(keyPath: "backgroundColor")
    tint.fromValue = layer.backgroundColor
    tint.toValue = toColor
    tint.damping = 5.0
    tint.initialVelocity = -10.0
//    tint.duration = 0.5
    tint.duration = tint.settlingDuration
    layer.add(tint, forKey: nil)
    layer.backgroundColor = toColor.cgColor
}

func roundCorners(layer: CALayer, toRadius: CGFloat) {
//    let round = CABasicAnimation(keyPath: "cornerRadius")
    let round = CASpringAnimation(keyPath: "cornerRadius")
    round.damping = 5.0
    round.fromValue = layer.cornerRadius
    round.toValue = toRadius
//    round.duration = 0.33
    round.duration = round.settlingDuration
    layer.add(round, forKey: nil)
    layer.cornerRadius = toRadius
}

class ViewController: UIViewController {

    // MARK: - IB outlets
    
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var cloud1: UIImageView!
    @IBOutlet weak var cloud2: UIImageView!
    @IBOutlet weak var cloud3: UIImageView!
    @IBOutlet weak var cloud4: UIImageView!
    
    // MARK: - IB actions
    
    @IBAction func login() {
        view.endEditing(true)
        
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
            self.loginButton.bounds.size.width += 80.0
        }, completion: { _ in
            self.showMessage(index: 0)
        })
        
        UIView.animate(withDuration: 0.33, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
            self.loginButton.center.y += 60.0
//            self.loginButton.backgroundColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
            let tintColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
            tintBackgroundColor(layer: self.loginButton.layer, toColor: tintColor)
            roundCorners(layer: self.loginButton.layer, toRadius: 25.0)
            
            self.spinner.center = CGPoint(x: 40.0, y: self.loginButton.frame.size.height / 2)
            self.spinner.alpha = 1.0
        }, completion: nil)
        
        let balloon = CALayer()
        balloon.contents = #imageLiteral(resourceName: "balloon").cgImage
        balloon.frame = CGRect(x: -50.0, y: 0.0, width: 50.0, height: 65.0)
        view.layer.insertSublayer(balloon, below: usernameTextField.layer)
        
        let flight = CAKeyframeAnimation(keyPath: "position")
        flight.duration = 12.0
        flight.values = [
            CGPoint(x: -50.0, y: 0.0),
            CGPoint(x: view.frame.width + 50.0, y: 160.0),
            CGPoint(x: -50.0, y: loginButton.center.y)
            ].map { NSValue(cgPoint: $0) }
        flight.keyTimes = [0.0, 0.5, 1.0]
        
        balloon.add(flight, forKey: nil)
        balloon.position = CGPoint(x: -50.0, y: loginButton.center.y)
    }
    
    // MARK: - futher UI
    
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    let status = UIImageView(image: #imageLiteral(resourceName: "banner"))
    let label = UILabel()
    let messages = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]
    
    var statusPosition = CGPoint.zero
    
    let info = UILabel()
    
    // MARK: - ViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Setup UI
        loginButton.layer.cornerRadius = 8.0
        loginButton.layer.masksToBounds = true
        
        spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
        spinner.alpha = 0.0
        spinner.startAnimating()
        loginButton.addSubview(spinner)
        
        status.center = loginButton.center
        status.isHidden = true
        view.addSubview(status)
        
        label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
        label.font = UIFont(name: "HelveticaNeue", size: 18.0)
        label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
        label.textAlignment = .center
        status.addSubview(label)
        
        statusPosition = status.center
        
        info.frame = CGRect(x: 0.0, y: loginButton.center.y + 60.0, width: view.frame.size.width, height: 30)
        info.backgroundColor = UIColor.clear
        info.font = UIFont(name: "HelveticaNeue", size: 12.0)
        info.textAlignment = .center
        info.textColor = UIColor.white
        info.text = "Tap on a field and enter username and password"
        view.insertSubview(info, belowSubview: loginButton)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        heading.center.x -= view.bounds.width
//        usernameTextField.center.x -= view.bounds.width
//        passwordTextField.center.x -= view.bounds.width
        
//        let flyRight = CABasicAnimation(keyPath: "position.x")
//        flyRight.fromValue = -view.bounds.size.width / 2
//        flyRight.toValue = view.bounds.size.width / 2
//        flyRight.duration = 0.5
//        flyRight.fillMode = kCAFillModeBoth
//        flyRight.isRemovedOnCompletion = false
//        flyRight.delegate = self
//
//        flyRight.setValue("form", forKey: "name")
//
//        flyRight.setValue(heading.layer, forKey: "layer")
//        heading.layer.add(flyRight, forKey: nil)
//
//        flyRight.setValue(usernameTextField.layer, forKey: "layer")
//        flyRight.beginTime = CACurrentMediaTime() + 0.3
//        usernameTextField.layer.add(flyRight, forKey: nil)
//
//        flyRight.setValue(passwordTextField.layer, forKey: "layer")
//        flyRight.beginTime = CACurrentMediaTime() + 0.4
//        passwordTextField.layer.add(flyRight, forKey: nil)
        
        let formGroup = CAAnimationGroup()
        formGroup.duration = 0.5
        formGroup.fillMode = kCAFillModeBackwards
        
        let fadeFieldIn = CABasicAnimation(keyPath: "opacity")
        fadeFieldIn.fromValue = 0.25
        fadeFieldIn.toValue = 1.0
        
        let flyRight = CABasicAnimation(keyPath: "position.x")
        flyRight.fromValue = -view.bounds.size.width / 2
        flyRight.toValue = view.bounds.size.width / 2
        
        formGroup.animations = [fadeFieldIn, flyRight]
        heading.layer.add(formGroup, forKey: nil)
        
        formGroup.beginTime = CACurrentMediaTime() + 0.3
        usernameTextField.layer.add(formGroup, forKey: nil)
        
        formGroup.beginTime = CACurrentMediaTime() + 0.4
        passwordTextField.layer.add(formGroup, forKey: nil)
        
        formGroup.delegate = self
        formGroup.setValue("form", forKey: "name")
        formGroup.setValue(usernameTextField.layer, forKey: "layer")
        formGroup.setValue(passwordTextField.layer, forKey: "layer")
        
//        cloud1.alpha = 0.0
//        cloud2.alpha = 0.0
//        cloud3.alpha = 0.0
//        cloud4.alpha = 0.0
        
        let fadeIn = CABasicAnimation(keyPath: "opacity")
        fadeIn.fromValue = 0.0
        fadeIn.toValue = 1.0
        fadeIn.duration = 0.5
        fadeIn.fillMode = kCAFillModeBackwards
        
        fadeIn.beginTime = CACurrentMediaTime() + 0.5
        cloud1.layer.add(fadeIn, forKey: nil)
        
        fadeIn.beginTime = CACurrentMediaTime() + 0.7
        cloud2.layer.add(fadeIn, forKey: nil)
        
        fadeIn.beginTime = CACurrentMediaTime() + 0.9
        cloud3.layer.add(fadeIn, forKey: nil)
        
        fadeIn.beginTime = CACurrentMediaTime() + 1.1
        cloud4.layer.add(fadeIn, forKey: nil)
        
//        loginButton.center.y += 30.0
//        loginButton.alpha = 0.0
        
        usernameTextField.layer.position.x = view.bounds.size.width / 2
        passwordTextField.layer.position.x = view.bounds.size.width / 2
        
//        delay(5.0) {
//            print("where are the fields?")
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
//        UIView.animate(withDuration: 0.5) {
//            self.heading.center.x += self.view.bounds.width
//        }
        
//        UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
//            self.usernameTextField.center.x += self.view.bounds.width
//        }, completion: nil)
        
//        UIView.animate(withDuration: 0.5, delay: 0.4, options: [], animations: {
//            self.passwordTextField.center.x += self.view.bounds.width
//        }, completion: nil)
        
//        UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
//            self.cloud1.alpha = 1.0
//        }, completion: nil)
//
//        UIView.animate(withDuration: 0.5, delay: 0.7, options: [], animations: {
//            self.cloud2.alpha = 1.0
//        }, completion: nil)
//
//        UIView.animate(withDuration: 0.5, delay: 0.9, options: [], animations: {
//            self.cloud3.alpha = 1.0
//        }, completion: nil)
//
//        UIView.animate(withDuration: 0.5, delay: 1.1, options: [], animations: {
//            self.cloud4.alpha = 1.0
//        }, completion: nil)
    
//        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
//            self.loginButton.center.y -= 30.0
//            self.loginButton.alpha = 1.0
//        }, completion: nil)
        let groupAnimation = CAAnimationGroup()
        groupAnimation.beginTime = CACurrentMediaTime() + 0.5
        groupAnimation.duration = 0.5
        groupAnimation.fillMode = kCAFillModeBackwards
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        let scaleDown = CABasicAnimation(keyPath: "transform.scale")
        scaleDown.fromValue = 3.5
        scaleDown.toValue = 1.0
        
        let rotate = CABasicAnimation(keyPath: "transform.rotation")
        rotate.fromValue = .pi / 4.0
        rotate.toValue = 0.0
        
        let fade = CABasicAnimation(keyPath: "opacity")
        fade.fromValue = 1.0
        fade.toValue = 0.0
        
        groupAnimation.animations = [scaleDown, rotate, fade]
        loginButton.layer.add(groupAnimation, forKey: nil)
        
//        animateCloud(cloud1)
//        animateCloud(cloud2)
//        animateCloud(cloud3)
//        animateCloud(cloud4)
        animateCloud(layer: cloud1.layer)
        animateCloud(layer: cloud2.layer)
        animateCloud(layer: cloud3.layer)
        animateCloud(layer: cloud4.layer)
        
        let flyLeft = CABasicAnimation(keyPath: "position.x")
        flyLeft.fromValue = info.layer.position.x + view.frame.size.width
        flyLeft.toValue = info.layer.position.x
        flyLeft.duration = 5.0
//        flyLeft.repeatCount = 2.5
//        flyLeft.autoreverses = true
//        flyLeft.speed = 2.0
//        info.layer.speed = 2.0
//        view.layer.speed = 2.0
        info.layer.add(flyLeft, forKey: "infoappear")
        
        let fadeLabelIn = CABasicAnimation(keyPath: "opacity")
        fadeLabelIn.fromValue = 0.2
        fadeLabelIn.toValue = 1.0
        fadeLabelIn.duration = 4.5
        info.layer.add(fadeLabelIn, forKey: "fadein")
    }
    
    func showMessage(index: Int) {
        label.text = messages[index]
        
        UIView.transition(with: status, duration: 0.33, options: [.curveEaseOut, .transitionCurlDown], animations: {
            self.status.isHidden  = false
        }) { _ in
            // transition completion
            delay(2.0, completion: {
                if index < self.messages.count - 1 {
                    self.removeMessage(index: index)
                } else {
                    // reset form
                    self.resetForm()
                }
            })
        }
    }
    
    func removeMessage(index: Int) {
        UIView.animate(withDuration: 0.33, delay: 0.0, options: [], animations: {
            self.status.center.x += self.view.frame.size.width
        }) { _ in
            self.status.isHidden = true
            self.status.center = self.statusPosition
            self.showMessage(index: index + 1)
        }
    }

    func resetForm() {
        UIView.transition(with: status, duration: 0.2, options: [.curveEaseOut, .transitionCurlUp], animations: {
            self.status.isHidden = true
            self.status.center = self.statusPosition
        }, completion: nil)
        
        UIView.animate(withDuration: 0.2) {
            self.spinner.center = CGPoint(x: -20.0, y: 16.0)
            self.spinner.alpha = 0.0
            
//            self.loginButton.backgroundColor = UIColor(red: 0.63, green: 0.84, blue: 0.35, alpha: 1.0)
            let tintColor = UIColor(red: 0.63, green: 0.84, blue: 0.35, alpha: 1.0)
            tintBackgroundColor(layer: self.loginButton.layer, toColor: tintColor)
            self.loginButton.bounds.size.width -= 80.0
            self.loginButton.center.y -= 60.0
            roundCorners(layer: self.loginButton.layer, toRadius: 10.0)
        }
        
        let wobble = CAKeyframeAnimation(keyPath: "transform.rotation")
        wobble.duration = 0.25
        wobble.repeatCount = 4
        wobble.values = [0.0, -.pi/4.0, 0.0, .pi/4.0, 0.0]
        wobble.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
        heading.layer.add(wobble, forKey: nil)
    }
    
    func animateCloud(_ cloud: UIImageView) {
        let cloudSpeed = 60.0 / view.frame.size.width
        let duration = (view.frame.size.width - cloud.frame.origin.x) * cloudSpeed
        UIView.animate(withDuration: TimeInterval(duration), delay: 0.0, options: .curveLinear, animations: {
            cloud.frame.origin.x = self.view.frame.size.width
        }) { _ in
            cloud.frame.origin.x = -cloud.frame.size.width
            self.animateCloud(cloud)
        }
    }
    
    func animateCloud(layer: CALayer) {
        let cloudSpeed = 60.0 / Double(view.layer.frame.size.width)
        let duration: TimeInterval = Double(view.frame.size.width - layer.frame.origin.x) * cloudSpeed
        
        let cloudMove = CABasicAnimation(keyPath: "position.x")
        cloudMove.duration = duration
        cloudMove.toValue = self.view.bounds.width + layer.bounds.width / 2
        cloudMove.delegate = self
        cloudMove.setValue("cloud", forKey: "name")
        cloudMove.setValue(layer, forKey: "layer")
        layer.add(cloudMove, forKey: nil)
    }
}

extension ViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
//        print("animation did finish")
        guard let name = anim.value(forKey: "name") as? String else {
            return
        }
        
        if name == "form" {
            // form filed found
            let layer = anim.value(forKey: "layer") as? CALayer
            anim.setValue(nil, forKey: "layer")
            
//            let pulse = CABasicAnimation(keyPath: "transform.scale")
            let pulse = CASpringAnimation(keyPath: "transform.scale")
            pulse.damping = 7.5
            pulse.fromValue = 1.25
            pulse.toValue = 1.0
//            pulse.duration = 0.25
            pulse.duration = pulse.settlingDuration
            layer?.add(pulse, forKey: nil)
        }
        
        if name == "cloud" {
            if let layer = anim.value(forKey: "layer") as? CALayer {
                anim.setValue(nil, forKey: "layer")
                layer.position.x = -layer.bounds.width / 2
                delay(0.5) {
                    self.animateCloud(layer: layer)
                }
            }
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let runningAnimations = info.layer.animationKeys() else {
            return
        }
        print(runningAnimations)
        info.layer.removeAnimation(forKey: "infoappear")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else  { return }
        
        if text.count < 5 {
            // add animations here
            let jump = CASpringAnimation(keyPath: "position.y")
            jump.fromValue = textField.layer.position.y + 1.0
            jump.toValue = textField.layer.position.y
            jump.initialVelocity = 100.0
            jump.mass = 10.0
            jump.stiffness = 1500.0
            jump.damping = 50.0
            jump.duration = jump.settlingDuration
            textField.layer.add(jump, forKey: nil)
            
            textField.layer.borderWidth = 3.0
            textField.layer.borderColor = UIColor.clear.cgColor
        
            let flash = CASpringAnimation(keyPath: "borderColor")
            flash.damping = 7.0
            flash.stiffness = 200.0
            flash.fromValue = UIColor(red: 1.0, green: 0.27, blue: 0.0, alpha: 1.0).cgColor
            flash.toValue = UIColor.white.cgColor
            flash.duration = flash.settlingDuration
            textField.layer.add(flash, forKey: nil)
        }
    }
}
