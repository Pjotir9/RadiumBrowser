//
//  AddressBar.swift
//  RadiumBrowser
//
//  Created by bslayter on 1/31/17.
//  Copyright © 2017 bslayter. All rights reserved.
//

import UIKit

class AddressBar: UIView, UITextFieldDelegate {
    
    static let standardHeight: CGFloat = 44
	
	var backButton: UIButton?
	var forwardButton: UIButton?
    var addressField: UITextField?
	
	weak var tabContainer: TabContainerView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Colors.radiumGray
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
		
		backButton = UIButton().then { [unowned self] in
			$0.setTitle("<-", for: .normal)
			$0.setTitleColor(.black, for: .normal)
			$0.setTitleColor(.lightGray, for: .disabled)
			$0.isEnabled = false
			
			self.addSubview($0)
			$0.snp.makeConstraints { (make) in
				make.left.equalTo(self).offset(8)
				make.width.equalTo(32)
				make.centerY.equalTo(self)
			}
		}
		
		if isiPadUI {
			forwardButton = UIButton().then { [unowned self] in
				$0.setTitle("->", for: .normal)
				$0.setTitleColor(.black, for: .normal)
				$0.setTitleColor(.lightGray, for: .disabled)
				$0.isEnabled = false
				
				self.addSubview($0)
				$0.snp.makeConstraints { (make) in
					make.left.equalTo(self.backButton!.snp.right).offset(8)
					make.width.equalTo(32)
					make.centerY.equalTo(self)
				}
			}
		}
        
        addressField = SharedTextField().then { [unowned self] in
            $0.placeholder = "Address"
            $0.backgroundColor = .white
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.layer.borderWidth = 0.5
            $0.layer.cornerRadius = 4
            $0.inset = 8
            
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
            $0.keyboardType = .URL
			$0.delegate = self
			$0.clearButtonMode = .always
            
            self.addSubview($0)
            $0.snp.makeConstraints { (make) in
				if isiPadUI {
					make.left.equalTo(self.forwardButton!.snp.right).offset(8)
				} else {
					make.left.equalTo(self.backButton!.snp.right).offset(8)
				}
				make.top.equalTo(self).offset(8)
				make.bottom.equalTo(self).offset(-8)
				make.right.equalTo(self).offset(-8)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		tabContainer?.loadQuery(string: textField.text)
		textField.resignFirstResponder()
		return true
	}

}