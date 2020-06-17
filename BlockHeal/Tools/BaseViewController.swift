//
//  BaseViewController.swift
//  HamrameMan
//
//  Created by negar on 99/Ordibehesht/02 AP.
//  Copyright © 1399 negar. All rights reserved.
//
import BRYXBanner
import UIKit
import SwiftValidator
import IQKeyboardManagerSwift

class BaseViewController: UIViewController {

    let network: NetworkManager = NetworkManager.sharedInstance


    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let validator = Validator()
    var initialInteractivePopGestureRecognizerDelegate: UIGestureRecognizerDelegate?
    var textfieldDistances = [Int:CGFloat]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.shared.enableAutoToolbar = false

        navigationController?.view.semanticContentAttribute = .forceRightToLeft
        navigationController?.navigationBar.semanticContentAttribute = .forceRightToLeft
        navigationController?.isNavigationBarHidden = true

        registerTextFieldValidations()
        setupViews()
        configureViews()
        startCheckingNetwork()

        initialInteractivePopGestureRecognizerDelegate = self.navigationController?.interactivePopGestureRecognizer?.delegate
    }


    func listenToNotificationCenterObservers() { }
    func removeNotificationCenterObservers() { }

    func addKeyboardHandleGesture(){
        Log.i()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard)))
        setupViews()
    }

    func createBottomDarkLayer() {
        let frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        let darkViewBottom = UIView(frame: frame)
        darkViewBottom.tag = 42
        darkViewBottom.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(removeBottomSubView))
        darkViewBottom.addGestureRecognizer(dismissGesture)
        self.view.addSubview(darkViewBottom)
    }
    func removeBottomDarkLayer() {
        for each in view.subviews {
            if each.tag == 42 {
                each.removeFromSuperview()
            }
        }
    }
    func addBottomSubView<T: UIView>(nibName:String,height:CGFloat,viewType:T.Type) -> T{
        let bottomView = UIView(frame: CGRect(x: 0, y: self.view.bounds.height - height, width: self.view.bounds.width, height: height))
        bottomView.tag = 89
        bottomView.round(corners: [.layerMinXMinYCorner,.layerMaxXMinYCorner] , radius: 15)
        bottomView.clipsToBounds = true
        let nibView = Bundle.main.loadNibNamed(nibName, owner: nil, options: [:])![0] as! T
        nibView.clipsToBounds = true
        self.view.addSubview(bottomView)
        self.view.bringSubviewToFront(bottomView)
        bottomView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        bottomView.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
//        bottomView.heightAnchor.constraint(equalToConstant: height).isActive = true
        nibView.frame = bottomView.bounds
        bottomView.addSubview(nibView)
        bottomView.bringSubviewToFront(nibView)
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
            self.view.setNeedsLayout()
        }
        return nibView
    }

    @objc func removeBottomSubView() {
        self.view.viewWithTag(89)?.removeFromSuperview()
    }

    override func viewWillAppear(_ animated: Bool) {
        configureViews()
//        setupKeyboardDistance()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil

    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = initialInteractivePopGestureRecognizerDelegate
        listenToNotificationCenterObservers()
        removeNotificationCenterObservers()
    }

    func setupViews(){

    }
    func configureViews(){
    }
    
     func showDialogueMessage(title: String = "", messageImage: UIImage? = nil, messageDetail: String, _ color: UIColor = .systemOrange)  {
        Log.i()
        DispatchQueue.main.async {
            let banner = Banner(title: title, subtitle: messageDetail, image: messageImage, backgroundColor: color)
            banner.preferredStatusBarStyle = .lightContent
            banner.titleLabel.font = .IRANSansMobile_Bold(size: 15)
            banner.detailLabel.font = .IRANSansMobile(size: 14)
            banner.detailLabel.textAlignment = .center
            banner.dismissesOnTap = true
            banner.show(duration: 3.0)
        }
    }
    
    

    func setupKeyboardDistance(textField:UITextField) {
        if let dictionary = StoringData.keyboardDistances {
            if let value = dictionary[String(describing:textField.tag)] {
                if let valueInt = value as? CGFloat {
                    IQKeyboardManager.shared.keyboardDistanceFromTextField = valueInt
                }
               
            }
        }else{
            let distance = textField.frame.origin.y - self.view.frame.origin.y
            StoringData.keyboardDistances = [String(describing: textField.tag):distance]
            IQKeyboardManager.shared.keyboardDistanceFromTextField = distance
        }
    }


    @objc func hideKeyboard(){
        Log.i()
        self.view.endEditing(true)
    }


    func registerTextFieldValidations(){
        Log.i()

        validator.styleTransformers(success:{ (validationRule) -> Void in
            Log.i("\(validationRule.field.self) => Successful")
            // clear error label
            validationRule.errorLabel?.isHidden = true
            validationRule.errorLabel?.text = ""

            if let textField = validationRule.field as? UITextField {
                textField.layer.borderColor = UIColor.green.cgColor
                textField.layer.borderWidth = 0.5
            } else if let textField = validationRule.field as? UITextView {
                textField.layer.borderColor = UIColor.green.cgColor
                textField.layer.borderWidth = 0.5
            }
        }, error:{ (validationError) -> Void in
            Log.e("\(validationError.field.self) => Failed")
            validationError.errorLabel?.isHidden = false
            validationError.errorLabel?.text = validationError.errorMessage
            if let textField = validationError.field as? UITextField {
                textField.layer.borderColor = UIColor.red.cgColor
                textField.layer.borderWidth = 1.0
            } else if let textField = validationError.field as? UITextView {
                textField.layer.borderColor = UIColor.red.cgColor
                textField.layer.borderWidth = 1.0
            }
        })

    }
    
    func doShakeFunction(){
        Log.i()
        
    }
    
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            UIView.animate(withDuration: 0.4) {
                self.doShakeFunction()
            }
        }
    }

    func notifUserAboutNetwork(){
        DispatchQueue.main.async {
            DialogueHelper.showStatusBarErrorMessage(errorMessageStr: "لطفا اتصال خود به اینترنت را بررسی کنید.")
        }
    }



    func startCheckingNetwork(){

        network.reachability.whenUnreachable = { _ in
            Log.i("Netowk Lost")
                self.notifUserAboutNetwork()
        }

        NetworkManager.isUnreachable { _ in
            Log.i("Netowk Lost")
            DispatchQueue.main.async {
                self.notifUserAboutNetwork()
            }

        }
    }

}


extension BaseViewController: ValidationDelegate {
    func validationSuccessful() {
        Log.i("Validation Successful")
    }

    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        Log.e("Validation Failed")
    }
}

