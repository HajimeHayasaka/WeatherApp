//
//  ViewController.swift
//  WeatherApp
//
//  Created by 早坂甫 on 2018/12/17.
//  Copyright © 2018年 早坂甫. All rights reserved.
//

import UIKit
import SCLAlertView

class ViewController: UIViewController {
    

    // テスト用カウンタ
    var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 背景色をセット
        self.view.backgroundColor = UIColor(named: "skyblue")
        
        // MARK:背景の雲表示をテスト
        let backImage = UIImage(named: "cloud")
        let backImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height))
        backImageView.image = backImage
        backImageView.contentMode = UIImageView.ContentMode.scaleToFill
        self.view.addSubview(backImageView)

        
        // MARK:設定ボタン
        let settingButton = UIButton(frame: CGRect(x: 230, y: 0, width: 100, height: 100))
        settingButton.setTitle("設定", for: UIControl.State.normal)
        settingButton.setTitleColor(UIColor(named: "textGray"), for: UIControl.State.normal)
        settingButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(settingButton)
        settingButton.addTarget(self, action: #selector(settingButtonClicked(sender:)), for: UIControl.Event.touchUpInside)
        
        // MARK:設定エリアの表示（都道府県）
        let areaNameLabel = UILabel(frame: CGRect(x: 70, y: 80, width: 100, height: 100))
        areaNameLabel.text = "埼玉"
        areaNameLabel.textColor = UIColor(named: "textGray")
        areaNameLabel.font = UIFont.systemFont(ofSize: 45)
        self.view.addSubview(areaNameLabel)
        
        // MARK:気温の表示
        let temperatureLabel = UILabel(frame: CGRect(x: 230, y: 220, width: 150, height: 100))
        temperatureLabel.text = "27℃"
        temperatureLabel.textColor = UIColor(named: "textGray")
        temperatureLabel.font = UIFont.systemFont(ofSize: 45)
        self.view.addSubview(temperatureLabel)

        
        
        
        
    }
    
    // 設定ボタンを押された時の処理
    @objc func settingButtonClicked(sender: UIButton) {
        print("settingButtonClicked")
        SCLAlertView().showInfo("Important info", subTitle: "You are great")

        /*
        var weatherImage: UIImage? = nil
        let weatherImageView = UIImageView(frame: CGRect(x: 0, y: view.frame.height * 0.55, width: view.frame.width, height: 200))
        
        if count >= 2 {
            count = 0
        } else {
            count += 1
        }
        weatherImageView.removeFromSuperview()

        // MARK:天気の画像を表示
        switch count {
        case 0:
            weatherImage = UIImage(named: "sunny")
        case 1:
            weatherImage = UIImage(named: "cloudiness")
        case 2:
            weatherImage = UIImage(named: "snow")
        default:
            print("default")
        }
        weatherImageView.image = weatherImage
        weatherImageView.contentMode = UIImageView.ContentMode.scaleAspectFit
        self.view.addSubview(weatherImageView)
        */
        
    }

}

