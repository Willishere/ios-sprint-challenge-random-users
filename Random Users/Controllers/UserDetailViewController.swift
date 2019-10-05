//
//  UserDetailViewController.swift
//  Random Users
//
//  Created by William Chen on 10/4/19.
//  Copyright © 2019 Erica Sadun. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!

    @IBOutlet weak var emailLabel: UILabel!

    @IBOutlet weak var phoneNumber: UILabel!
    
    var key: Cache<URL, UIImage>?
    var user: UsersPhotoReference? {
        didSet{
            updateViews()
        }
    }
    
    
    
    func updateViews(){
        guard let user = user,
            let image = user.picture,
            let key = key
        else {return}
        
        imageView.image = key.value(key: image)
        detailLabel.text = user.name
        emailLabel.text = user.email
        phoneNumber.text = user.phone
        
        
    }
}


