//
//  ContactsDetailsViewController.swift
//  CodingChallenge
//
//  Created by Sraavan Chevireddy on 5/5/22.
//

import Foundation
import UIKit
import Kingfisher

class ContactDetailsViewController : UIViewController{
    
    private var contactInfo : ContactsListModel!
    private var scrollView : UIScrollView!
    private var profileImage : UIImageView!
    private var lbl_fullName: UILabel!
    private var lbl_email : UILabel!
    private var lbl_phone : UILabel!
    
    convenience init(_ contactInformation: ContactsListModel){
        self.init()
        contactInfo = contactInformation
    }
    override func viewDidLoad() {
        navigationItem.title = contactInfo.results.first?.name.first
        view.backgroundColor = UIColor.white
        setupImageComponents()
        setUpBasicInformation()
    }
    
    private func setupImageComponents(){
        let profileUrl = URL(string: (contactInfo.results.first?.picture.large)!)
        
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.fillWithMasterView()
        
        profileImage = UIImageView()
        profileImage.layer.cornerRadius = 100
        profileImage.clipsToBounds = true
        profileImage.kf.setImage(
            with: profileUrl,
            options: [
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
                .transition(.fade(0.25)),
            ],
            progressBlock: { receivedSize, totalSize in
                // Progress updated
            },
            completionHandler: { result in
                // Done
            }
        )
        [profileImage].forEach({scrollView.addSubview($0)})
        profileImage.setupAutoAnchors(top: scrollView.topAnchor, leading: nil, bottom: nil, trailing: nil, withPadding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .init(width: 200, height: 200))
        profileImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
    }
    
    private func setUpBasicInformation(){
        lbl_fullName = {
            let modalView = UILabel()
            modalView.attributedText = createAttributedString(titleText: (contactInfo.results.first?.name.title)!, titleColor: .gray, titleFont: UIFont(name: "Arial Rounded MT Bold", size: 18)!, valueText: (contactInfo.results.first?.name.first)! + " " + (contactInfo.results.first?.name.last)!, valColor: .black, valFont: UIFont(name: "Arial Rounded MT Bold", size: 22)!)
            return modalView
        }()
        scrollView.addSubview(lbl_fullName)
        lbl_fullName.setupAutoAnchors(top: profileImage.bottomAnchor, leading: nil, bottom: nil, trailing: nil, withPadding: .init(top: 10, left: 10, bottom: 10, right: 10), size: .zero)
        lbl_fullName.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
    }
    
    

}
