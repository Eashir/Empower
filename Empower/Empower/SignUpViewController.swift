//
//  SignUpViewController.swift
//  Empower
//
//  Created by Eashir Arafat on 10/28/18.
//  Copyright © 2018 Eashir Arafat. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
	
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
	@IBOutlet weak var errorLabel: UILabel!
	
	@IBOutlet weak var signUpButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		emailTextField.delegate = self
		passwordTextField.delegate = self
		
		setupViews()
	}
	
	func setupViews() {
		signUpButton.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
		signUpButton.layer.cornerRadius = signUpButton.frame.height/2
	}
	
	//MARK: - Actions
	
	@objc func signUpPressed() {
		Auth.auth().createUserAndRetrieveData(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authResult, error) in
			
			if error != nil {
				self.errorLabel.text = error?.localizedDescription
				return
			} else {
				let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
				let homeVC = storyBoard.instantiateInitialViewController()
				self.present(homeVC!, animated: true, completion: nil)
			}
		}
	}
	
}

extension SignUpViewController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.view.endEditing(true)
		switch textField {
		case emailTextField:
			passwordTextField.becomeFirstResponder()
		default:
			textField.resignFirstResponder()
		}
		return true
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.view.endEditing(true)
	}
	
}




