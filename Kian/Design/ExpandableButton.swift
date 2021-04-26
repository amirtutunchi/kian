//
//  ExpandbleButton.swift
//  Avid
//
//  Created by Amir Tutunchi on 11/30/20.
//  Copyright © 2020 Kasra. All rights reserved.
//

import Foundation
import UIKit

fileprivate let buttonSize: CGFloat = 48
fileprivate let shadowOpacity: Float = 0.7


class ExpandbleFlotingButton: UIView {
    
    var delegate: ExpandbleFlotingButtonDelegate!
    
    lazy var menuButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(#imageLiteral(resourceName: "addRequest"), for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = buttonSize / 2
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

//    lazy var dogButton: UIButton = {
//      let button = UIButton(frame: .zero)
//      button.setTitle("🐶", for: .normal)
//      button.layer.cornerRadius = buttonSize / 2
//      button.isHidden = true
//      return button
//    }()

    lazy var textButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("New", for: .normal)
        button.titleLabel?.font = Font(.installed(.Nunito_Regular), size: .custom(18)).instance
        button.layer.cornerRadius = buttonSize / 2
        button.isHidden = true
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var emptyButton: UIButton = {
        let button = UIButton(frame: .zero)
//        button.setTitle("New".localized(), for: .normal)
        button.titleLabel?.font = Font(.installed(.Nunito_Regular), size: .custom(18)).instance
        button.layer.cornerRadius = buttonSize / 2
        button.isHidden = true
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonTapped() {
        if delegate != nil {
            delegate.buttonTapped()
        }
    }

    lazy var expandedStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.isHidden = true
        stackView.addArrangedSubview(emptyButton)
        stackView.addArrangedSubview(textButton)
        stackView.spacing = -10
        return stackView
    }()

    lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.addArrangedSubview(expandedStackView)
        stackView.addArrangedSubview(menuButton)
//        stackView.addArrangedSubview(expandedStackView)
        stackView.spacing = -10
        return stackView
    }()
    
    // ...
      
      
    @objc func handleTogglePanelButtonTapped() {
//        self.textButton.isHidden = !self.textButton.isHidden
        self.expandedStackView.subviews.forEach { $0.isHidden = !$0.isHidden }
        UIView.animate(
          withDuration: 0.3, delay: 0, options: .curveEaseIn,
          animations: {
            
            self.expandedStackView.isHidden = !self.expandedStackView.isHidden
          })
      }
    
    func expand() {
//        self.expandedStackView.subviews.forEach { $0.isHidden = false }
        if self.expandedStackView.isHidden == true {
            UIView.animate(
                withDuration: 0.3, delay: 0, options: .curveEaseIn,
                animations: {
                    self.expandedStackView.subviews.forEach { $0.isHidden = false }
                    self.expandedStackView.isHidden = false
                })
        }
    }
    
    func unExpand() {
//        self.expandedStackView.subviews.forEach { $0.isHidden = true }
        if self.expandedStackView.isHidden == false {
            UIView.animate(
                withDuration: 0.3, delay: 0, options: .curveEaseIn,
                animations: {
                    self.expandedStackView.subviews.forEach { $0.isHidden = true }
                    self.expandedStackView.isHidden = true
                })
        }
    }

  // ...
  override init(frame: CGRect) {
    super.init(frame: frame)
//    backgroundColor = UIColor(red: 81/255, green: 166/255, blue: 219/255, alpha: 1)
    backgroundColor = UIColor.appColor(.MagentaPallete)

    layer.cornerRadius = buttonSize / 2
    layer.shadowColor = UIColor.lightGray.cgColor
    layer.shadowOpacity = shadowOpacity

    layer.shadowOffset = .zero
    
    addSubview(containerStackView)
    setConstraints()
    handleTogglePanelButtonTapped()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setConstraints() {
    // Main button
    menuButton.translatesAutoresizingMaskIntoConstraints = false
    menuButton.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
    menuButton.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true

    // Dog button
//    dogButton.translatesAutoresizingMaskIntoConstraints = false
//    dogButton.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
//    dogButton.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true

    // Cat button
    textButton.translatesAutoresizingMaskIntoConstraints = false
    textButton.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
    textButton.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true

    // Container stack view
    containerStackView.translatesAutoresizingMaskIntoConstraints = false
    containerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    containerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

    translatesAutoresizingMaskIntoConstraints = false
    self.widthAnchor.constraint(equalTo: containerStackView.widthAnchor).isActive = true
    self.heightAnchor.constraint(equalTo: containerStackView.heightAnchor).isActive = true
    
//    superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: superview, attribute: .leading, multiplier: 1, constant: 20))
  }
  
  // ...
}


protocol ExpandbleFlotingButtonDelegate {
    func buttonTapped()
}



