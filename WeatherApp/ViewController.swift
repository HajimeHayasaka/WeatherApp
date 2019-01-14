//
//  ViewController.swift
//  WeatherApp
//
//  Created by 早坂甫 on 2018/12/17.
//  Copyright © 2018年 早坂甫. All rights reserved.
//

import UIKit
import SCLAlertView
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    // テスト用カウンタ
    // var count: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // 背景色をセット
        self.view.backgroundColor = UIColor(named: "skyblue")

        // MARK: 背景の雲表示をテスト
        let backImage = UIImage(named: "cloud_background")
        var backImageView = UIImageView(frame: CGRect(x: view.frame.width * -0.4, y: view.frame.height * 0.6, width: 400, height: 160))
        backImageView.image = backImage
        self.view.addSubview(backImageView)
        backImageView = UIImageView(frame: CGRect(x: view.frame.width * 0.5, y: view.frame.height * 0.8, width: 270, height: 110))
        backImageView.image = backImage
        self.view.addSubview(backImageView)

        // MARK: 設定ボタン
        let settingButton = UIButton(frame: CGRect(x: view.frame.width * 0.5, y: view.frame.height * 0.05, width: 200, height: 80))
        settingButton.setTitle("設定", for: UIControl.State.normal)
        settingButton.setTitleColor(UIColor(named: "textGray"), for: UIControl.State.normal)
        settingButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        settingButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20) // 右に余白を入れてタイトルが中央に表示されるよう微調整。
        let settingButtonImage = UIImage(named: "cloud_setting")
        settingButton.setBackgroundImage(settingButtonImage, for: UIControl.State.normal)
        self.view.addSubview(settingButton)
        settingButton.addTarget(self, action: #selector(settingButtonClicked(sender:)), for: UIControl.Event.touchUpInside)

        // MARK: エリアの表示（都道府県）
        let areaNameBackImage = UIImage(named: "cloud_area")
        let areaNameBackImageView = UIImageView(frame: CGRect(x: view.frame.width * -0.3, y: view.frame.height * 0.12, width: 360, height: 140))
        areaNameBackImageView.image = areaNameBackImage
        self.view.addSubview(areaNameBackImageView)
        let areaNameLabel = UILabel(frame: CGRect(x: areaNameBackImageView.frame.origin.x + 20,
                                                  y: areaNameBackImageView.frame.origin.y,
                                                  width: areaNameBackImageView.frame.width,
                                                  height: areaNameBackImageView.frame.height))
        areaNameLabel.text = "埼玉"
        areaNameLabel.textColor = UIColor(named: "textGray")
        areaNameLabel.font = UIFont.systemFont(ofSize: 45)
        areaNameLabel.textAlignment = NSTextAlignment.center
        areaNameLabel.adjustsFontSizeToFitWidth = true
        self.view.addSubview(areaNameLabel)

        // MARK: 気温の表示
        let temperatureBackImage = UIImage(named: "cloud_temp")
        let temperatureBackImageView = UIImageView(frame: CGRect(x: view.frame.width * 0.4, y: view.frame.height * 0.3, width: 300, height: 130))
        temperatureBackImageView.image = temperatureBackImage
        self.view.addSubview(temperatureBackImageView)
        let temperatureLabel = UILabel(frame: CGRect(x: temperatureBackImageView.frame.origin.x - 20,
                                                     y: temperatureBackImageView.frame.origin.y - 5,
                                                     width: temperatureBackImageView.frame.width,
                                                     height: temperatureBackImageView.frame.height))
        temperatureLabel.text = "27℃"
        temperatureLabel.textColor = UIColor(named: "textGray")
        temperatureLabel.font = UIFont.systemFont(ofSize: 45)
        temperatureLabel.textAlignment = NSTextAlignment.center
        temperatureLabel.adjustsFontSizeToFitWidth = true
        self.view.addSubview(temperatureLabel)

        //お天気APIから東京の天気を取得する
        let url: String = "http://weather.livedoor.com/forecast/webservice/json/v1?city=110010"
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                let json: JSON = JSON(response.result.value ?? kill)
                print(json)
                self.showWeatherAlert(title: json["title"].stringValue, message: json["description"]["text"].stringValue)
            case .failure(let error):
                print(error)
            }
        }

    }

    // 設定ボタンを押された時の処理
    @objc func settingButtonClicked(sender: UIButton) {
        print("settingButtonClicked")
        SCLAlertView().showInfo("Important info", subTitle: "You are great")
    }

    func showWeatherAlert(title: String, message: String) {
        // アラートを作成
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))

        // アラート表示
        // self.present(alert, animated: true, completion: nil)
    }

}

