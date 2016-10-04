//
//  YZContentViewController.swift
//  PageView
//
//  Created by luckyxmobile on 16/10/4.
//  Copyright © 2016年 luckyxmobile. All rights reserved.
//

import UIKit

class YZContentViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var pageIndex: Int!
    var titleText: String!
    var imageFile: String!
    
    override func viewDidLoad() {
        titleLabel.text = titleText
        imageView.image = UIImage.init(named: imageFile)
    }
}
