//
//  PageItemController.swift
//  kLibrary
//
//  Created by Ky Nguyen on 1/26/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//


import UIKit

class PageItemController: UIViewController {

    var itemIndex: Int = 0
    var imageName: String = "" {
        
        didSet {
            
            if let imageView = contentImageView {
                imageView.image = UIImage(named: imageName)
            }
            
        }
    }
    
    var placeName : String = "" {
        
        didSet {
            if let place = placeNameLabel {
                place.text = placeName
            }
        }
    }
    @IBOutlet weak var placeNameLabel: UILabel!
    
    @IBOutlet var contentImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentImageView!.image = UIImage(named: imageName)
        placeNameLabel!.text = placeName
    }

}
