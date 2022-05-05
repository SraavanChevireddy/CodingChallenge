//
//  ContactsTableViewCell.swift
//  CodingChallenge
//
//  Created by Sraavan Chevireddy on 5/5/22.
//

import UIKit
import Kingfisher

class ContactsTableViewCell : UITableViewCell{
    
    var card : ContactsListModel!{
        didSet{
            lbl_title.text = (card.results.first?.name.first)! + " " + (card.results.first?.name.last)!
            let profileUrl = URL(string: (card.results.first?.picture.thumbnail)!)
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
        }
    }
    
    private var lbl_title: UILabel!
    private var baseView: UIView!
    private var profileImage : UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUIComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUIComponents(){
        backgroundColor = .clear
        selectionStyle = .none
        baseView = {
            let modalView = UIView()
            modalView.layer.cornerRadius = 10
            modalView.clipsToBounds = true
            return modalView
        }()
        
        profileImage = {
            let modalView = UIImageView()
            modalView.layer.cornerRadius = 30
            modalView.clipsToBounds = true
            return modalView
        }()
        lbl_title = {
            let modalView = UILabel()
            modalView.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
            return modalView
        }()
        contentView.addSubview(baseView)
        baseView.fillWithMasterView(withPadding: .init(top: 10, left: 10, bottom: 10, right: 10))
        
        [profileImage, lbl_title].forEach({baseView.addSubview($0)})
        profileImage.setupAutoAnchors(top: baseView.topAnchor, leading: baseView.leadingAnchor, bottom: baseView.bottomAnchor, trailing: nil, withPadding: .init(top: 5, left: 5, bottom: 5, right: 5), size: .init(width: 60, height: 60))
        lbl_title.setupAutoAnchors(top: nil, leading: profileImage.trailingAnchor, bottom: nil, trailing: baseView.trailingAnchor, withPadding: .init(top: 0, left: 20, bottom: 0, right: 10), size: .zero)
        lbl_title.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive = true
    }
}
