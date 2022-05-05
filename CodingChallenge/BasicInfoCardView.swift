//
//  BasicInfoCardView.swift
//  CodingChallenge
//
//  Created by Sraavan Chevireddy on 5/6/22.
//

import Foundation
import UIKit

class BasicInformationCardView : UIView{
    
    // UI Components
    private var contentImage:  UIImageView!
    private var lbl_heading: UILabel!
    
    // Info components
    private var imageName:String!
    private var str_title:String!
    private var str_value :String!
    
    convenience init(_ imageName: String,_ title:String,_ value: String){
        self.init()
        self.imageName = imageName
        str_title = title
        str_value = value
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUIComponents()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    private func loadUIComponents(){
        contentImage = {
            let modalView = UIImageView(image: UIImage(systemName: imageName))
            modalView.tintColor = .gray
            return modalView
        }()
        
        
        
    }
}
