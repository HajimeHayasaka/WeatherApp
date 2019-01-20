//
//  TemperatureView.swift
//  WeatherApp
//
//  Created by 早坂甫 on 2019/01/16.
//  Copyright © 2019年 早坂甫. All rights reserved.
//

import UIKit

class TemperatureView: UIView {

    var imageView: UIImageView!
    var label: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .orange

        imageView = UIImageView()
        imageView.image = UIImage(named: "tab-icon-sample")
        imageView.backgroundColor = .red
        self.addSubview(imageView)

        label = UILabel()
        label.text = "Hello"
        label.backgroundColor = .yellow
        label.textAlignment = .center
        self.addSubview(label)
    }

    override func layoutSubviews() {
        let viewWidth = frame.width
        let viewHeight = frame.height
        imageView.frame = CGRect(x: 0, y: 0, width: viewWidth * 0.3, height: viewHeight)
        label.frame = CGRect(x: viewWidth * 0.3, y: 0, width: viewWidth * 0.3, height: viewHeight)
    }
}
