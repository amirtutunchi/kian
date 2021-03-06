//
//  TextViewWithPlaceHolder.swift
//  Jouritm
//
//  Created by Amir Tutunchi on 4/2/20.
//  Copyright © 2020 jouritm. All rights reserved.
//

import Foundation
import UIKit

//@IBDesignable class PlaceholderTextView: UITextView {
//
//   var placeholderLabel: UILabel?
//
//      override init(frame: CGRect, textContainer: NSTextContainer?) {
//          super.init(frame: frame, textContainer: textContainer)
//          sharedInit()
//      }
//
//      required init?(coder aDecoder: NSCoder) {
//          super.init(coder: aDecoder)
//          sharedInit()
//      }
//
//      override func prepareForInterfaceBuilder() {
//          sharedInit()
//      }
//
//      func sharedInit() {
//          refreshPlaceholder()
//          NotificationCenter.default.addObserver(self, selector: #selector(textChanged), name: UITextView.textDidChangeNotification, object: nil)
//      }
//
//      @IBInspectable var placeholder: String? {
//          didSet {
//              refreshPlaceholder()
//          }
//      }
//
//      @IBInspectable var placeholderColor: UIColor? = .darkGray {
//          didSet {
//              refreshPlaceholder()
//          }
//      }
//
//      @IBInspectable var placeholderFontSize: CGFloat = 14 {
//          didSet {
//              refreshPlaceholder()
//          }
//      }
//
//      func refreshPlaceholder() {
//          if placeholderLabel == nil {
//            placeholderLabel = UILabel.init(frame: self.frame)
//              let contentView = self.subviews.first ?? self
//
//              contentView.addSubview(placeholderLabel!)
//              placeholderLabel?.translatesAutoresizingMaskIntoConstraints = false
//
//              placeholderLabel?.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: textContainerInset.left + 4).isActive = true
//              placeholderLabel?.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: textContainerInset.right + 4).isActive = true
//              placeholderLabel?.topAnchor.constraint(equalTo: contentView.topAnchor, constant: textContainerInset.top).isActive = true
//            placeholderLabel?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: textContainerInset.bottom).isActive = true
//          }
//          placeholderLabel?.text = placeholder
//          placeholderLabel?.textColor = placeholderColor
//          placeholderLabel?.font = UIFont.systemFont(ofSize: placeholderFontSize)
//      }
//
//      @objc func textChanged() {
//          if self.placeholder?.isEmpty ?? true {
//              return
//          }
//
//          UIView.animate(withDuration: 0.25) {
//              if self.text.isEmpty {
//                  self.placeholderLabel?.alpha = 1.0
//              } else {
//                  self.placeholderLabel?.alpha = 0.0
//              }
//          }
//      }
//
//      override var text: String! {
//          didSet {
//              textChanged()
//          }
//      }
//
//
//}

//extension PlaceholderTextView: UITextViewDelegate {
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if isPlaceholderVisible {
//            isPlaceholderVisible = false
//        }
//    }
//
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if text.isEmpty {
//            isPlaceholderVisible = true
//        }
//    }
//}
