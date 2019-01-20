//
//  ButtonView.swift
//  WeatherApp
//
//  Created by 早坂甫 on 2019/01/20.
//  Copyright © 2019年 早坂甫. All rights reserved.
//

import UIKit

class ButtonView: UIView {

    var button: UIButton!
    var label: UILabel!
    var labelFrame: CGRect!

    // UIViewクラスを使う場合に必要な初期化処理（その１）
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // UIViewクラスを使う場合に必要な初期化処理（その２）
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    // 引数を増やしたイニシャライザを作成
    init(image: String, name: String, frame: CGRect) {
        super.init(frame: frame)

        labelFrame = CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)

        button = UIButton()
        button.setBackgroundImage(UIImage(named: image), for: UIControl.State.normal)
        self.addSubview(button)

        label = UILabel()
        label.text = name
        label.textColor = UIColor(named: "textGray")
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = NSTextAlignment.center
        label.adjustsFontSizeToFitWidth = true
        button.addSubview(label)

    }

    // SubView, Layer を更新する場合に使用するメソッド
    // Question:super.layoutSubview()は不要なのか？呼ばなくても大丈夫な理由。
    override func layoutSubviews() {
        button.frame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height)
        label.frame =  labelFrame
    }
}
