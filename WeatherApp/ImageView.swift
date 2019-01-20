//
//  ImageView.swift
//  WeatherApp
//
//  Created by 早坂甫 on 2019/01/20.
//  Copyright © 2019年 早坂甫. All rights reserved.
//

import UIKit

class ImageView: UIView {

    var imageView: UIImageView!
    var label: UILabel!
    var labelFrame: CGRect!
    var labelFlag: Bool = false
    var defaultLabelText: String!

    // UIViewクラスを使う場合に必要な初期化処理（その１）
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // UIViewクラスを使う場合に必要な初期化処理（その２）
    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        self.addSubview(imageView)
    }

    // 画像＋ラベルで使いたい時用
    init(image: String, frameOfImage: CGRect, text: String, frameOfLabel: CGRect) {
        super.init(frame: frameOfImage)

        imageView = UIImageView()
        imageView.image = UIImage(named: image)
        self.addSubview(imageView)

        labelFrame = frameOfLabel
        labelFlag = true
        defaultLabelText = text

        label = UILabel()
        label.text = text
        label.textColor = UIColor(named: "textGray")
        label.font = UIFont.systemFont(ofSize: 35)
        label.textAlignment = NSTextAlignment.center
        label.adjustsFontSizeToFitWidth = true
        imageView.addSubview(label)

    }

    // SubView, Layer を更新する場合に使用するメソッド
    // Question:super.layoutSubview()は不要なのか？呼ばなくても大丈夫な理由。
    override func layoutSubviews() {
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height)
        if labelFlag { label.frame = labelFrame }
    }

    func setDefaultLabelText() { label.text = defaultLabelText }
}
