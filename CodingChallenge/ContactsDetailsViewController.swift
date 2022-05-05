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
    
    // Basic information labels
    private var lbl_fullName: UILabel!
    private var lbl_email : UILabel!
    private var lbl_phone : UILabel!
    private var lbl_dob: UILabel!
    private var lbl_street: UILabel!
    private var lbl_state: UILabel!
    private var lbl_postalCode: UILabel!
    
    
    
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
        
        lbl_email = {
            let modalView = UILabel()
            if let email = contactInfo.results.first?.email{
                modalView.attributedText = createAttributedString(titleText: "Email ", titleColor: .gray, titleFont: .preferredFont(forTextStyle: .body), valueText: email, valColor: .black, valFont: UIFont(name: "Arial Rounded MT Bold", size: 19)!)
            }
            return modalView
        }()
        
        lbl_phone = {
            let modalView = UILabel()
            if let phone = contactInfo.results.first?.phone{
                modalView.attributedText = createAttributedString(titleText: "Phone ", titleColor: .gray, titleFont: .preferredFont(forTextStyle: .body), valueText: phone, valColor: .black, valFont: UIFont(name: "Arial Rounded MT Bold", size: 19)!)
            }
            return modalView
        }()
        
        lbl_dob = {
            let modalView = UILabel()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let dob = contactInfo.results.first?.dob.date,let dateOfBirth = dateFormatter.date(from: dob){
                dateFormatter.dateFormat = "MMM dd, yyyy"
                modalView.attributedText = createAttributedString(titleText: "Date of Birth ", titleColor: .gray, titleFont: .preferredFont(forTextStyle: .body), valueText: dateFormatter.string(from: dateOfBirth), valColor: .black, valFont: UIFont(name: "Arial Rounded MT Bold", size: 19)!)
            }
            return modalView
        }()
        
        lbl_street = {
            let modalView = UILabel()
            if let location = contactInfo.results.first?.location{
                let str_address = "# \(location.street.number) \(location.street.name)"
                modalView.attributedText = createAttributedString(titleText: "Street ", titleColor: .gray, titleFont: .preferredFont(forTextStyle: .body), valueText: str_address, valColor: .black, valFont: UIFont(name: "Arial Rounded MT Bold", size: 19)!)
            }
            modalView.numberOfLines = 0
            return modalView
        }()
        
        lbl_state = {
            let modalView = UILabel()
            if let location = contactInfo.results.first?.location{
                let str_address = "#\(location.street.number) \(location.street.name), \(location.city) - \(location.state) \(location.postcode)"
                modalView.attributedText = createAttributedString(titleText: "State ", titleColor: .gray, titleFont: .preferredFont(forTextStyle: .body), valueText: location.state, valColor: .black, valFont: UIFont(name: "Arial Rounded MT Bold", size: 19)!)
            }
            modalView.numberOfLines = 0
            return modalView
        }()
        
        lbl_postalCode = {
            let modalView = UILabel()
            if let location = contactInfo.results.first?.location{
                modalView.attributedText = createAttributedString(titleText: "Postal Code ", titleColor: .gray, titleFont: .preferredFont(forTextStyle: .body), valueText: "\(location.postcode)", valColor: .black, valFont: UIFont(name: "Arial Rounded MT Bold", size: 19)!)
            }
            modalView.numberOfLines = 0
            return modalView
        }()
        
        [lbl_fullName, lbl_email, lbl_phone, lbl_dob, lbl_street, lbl_state, lbl_postalCode].forEach({scrollView.addSubview($0)})
        lbl_fullName.setupAutoAnchors(top: profileImage.bottomAnchor, leading: nil, bottom: nil, trailing: nil, withPadding: .init(top: 10, left: 10, bottom: 10, right: 10), size: .zero)
        lbl_fullName.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        lbl_email.setupAutoAnchors(top: lbl_fullName.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, withPadding: .init(top: 25, left: 10, bottom: 10, right: 10), size: .zero)
        
        lbl_phone.setupAutoAnchors(top: lbl_email.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, withPadding: .init(top: 25, left: 10, bottom: 10, right: 10), size: .zero)
        
        lbl_dob.setupAutoAnchors(top: lbl_phone.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, withPadding: .init(top: 25, left: 10, bottom: 10, right: 10), size: .zero)
        
        lbl_street.setupAutoAnchors(top: lbl_dob.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, withPadding: .init(top: 25, left: 10, bottom: 10, right: 10), size: .zero)
        lbl_state.setupAutoAnchors(top: lbl_street.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, withPadding: .init(top: 25, left: 10, bottom: 10, right: 10), size: .zero)
        lbl_postalCode.setupAutoAnchors(top: lbl_state.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, withPadding: .init(top: 25, left: 10, bottom: 10, right: 10), size: .zero)
        
    }
    
    
    
}
