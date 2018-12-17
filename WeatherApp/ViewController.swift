//
//  ViewController.swift
//  WeatherApp
//
//  Created by 早坂甫 on 2018/12/17.
//  Copyright © 2018年 早坂甫. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 背景色をセット
        self.view.backgroundColor = UIColor(named: "skyblue")
        
        // 背景の雲表示をテスト
        let backImage = UIImage(named: "cloud")
        let backImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height))
        backImageView.image = backImage
        backImageView.center = view.center
        backImageView.contentMode = UIImageView.ContentMode.scaleAspectFill
        self.view.addSubview(backImageView)

    }


}

