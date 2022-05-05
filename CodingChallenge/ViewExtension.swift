//
//  ViewExtension.swift
//  CodingChallenge
//
//  Created by Sraavan Chevireddy on 5/5/22.
//

import UIKit

extension UIView{
    func setUpAnchors(top : NSLayoutYAxisAnchor?, left : NSLayoutXAxisAnchor? , bottom : NSLayoutYAxisAnchor? , right : NSLayoutXAxisAnchor? , padding : UIEdgeInsets = .zero, size : CGSize = .zero)
    {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top
        {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let left = left
        {
            leftAnchor.constraint(equalTo: left, constant: padding.left).isActive = true
            
        }
        if let bottom = bottom
        {
            bottom.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if let right = right
        {
            rightAnchor.constraint(equalTo: right, constant: -padding.right).isActive = true
        }
        
        if size.width != 0
        {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0
        {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func fillWithMasterView(withPadding:UIEdgeInsets = .zero){
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor{
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: withPadding.top).isActive = true
        }
        if let superviewLeftAnchor = superview?.leftAnchor{
            leftAnchor.constraint(equalTo: superviewLeftAnchor, constant: withPadding.left).isActive = true
        }
        if let superviewBottomAnchor = superview?.bottomAnchor{
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -withPadding.bottom).isActive = true
        }
        if let superviewRightAnchor = superview?.rightAnchor{
            rightAnchor.constraint(equalTo: superviewRightAnchor, constant: -withPadding.right).isActive = true
        }
    }
    
    func setupAutoAnchors(top: NSLayoutYAxisAnchor?,leading: NSLayoutXAxisAnchor?,bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, withPadding: UIEdgeInsets = .zero, size: CGSize = .zero){
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top
        {
            topAnchor.constraint(equalTo: top, constant: withPadding.top).isActive = true
        }
        if let left = leading
        {
            leadingAnchor.constraint(equalTo: left, constant: withPadding.left).isActive = true
        }
        if let bottom = bottom
        {
            bottomAnchor.constraint(equalTo: bottom, constant: -withPadding.bottom).isActive = true
        }
        if let right = trailing
        {
            trailingAnchor.constraint(equalTo: right, constant: -withPadding.right).isActive = true
        }
        if size.width != 0
        {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0
        {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}

extension UIViewController{
    func createAttributedString(titleText:String,titleColor:UIColor,titleFont:UIFont,valueText:String,valColor:UIColor, valFont:UIFont) -> NSAttributedString{
        
        let titleAttributes = [NSAttributedString.Key.font: titleFont, NSAttributedString.Key.foregroundColor: titleColor]
          let subtitleAttributes = [NSAttributedString.Key.font: valFont, NSAttributedString.Key.foregroundColor: valColor]

     let titleString = NSMutableAttributedString(string: "\(titleText) ", attributes: titleAttributes)
     let subtitleString = NSAttributedString(string: valueText, attributes: subtitleAttributes)

     titleString.append(subtitleString)

     return titleString
    }
}

enum NetworkError: Error{
    case sourceNotFound
}
