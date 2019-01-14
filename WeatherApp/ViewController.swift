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

    let date: Int = 0                       // 表示する日（今日:0, 明日:1, 明後日:2）
    let userDefaults: UserDefaults = UserDefaults.standard
    var initCityId: String = "040010"      // 初期の地域ID
    var areaNameLabel: UILabel!
    var temperatureLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Key削除
        userDefaults.removeObject(forKey: "KEY_CITY_ID")

        // ユーザーデータの初期値をセット
        userDefaults.register(defaults: ["KEY_CITY_ID": initCityId])

        // お天気情報画面のレイアウトを描画
        weatherScreenView()

        // お天気情報を表示（地域と気温を表示）
        weatherInfoView(id: userDefaults.string(forKey: "KEY_CITY_ID")!)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
        weatherInfoView(id: userDefaults.string(forKey: "KEY_CITY_ID")!)
    }

    // MARK: 設定ボタン押下処理
    @objc func settingButtonClicked(sender: UIButton) {
        print("settingButtonClicked")
        let secondVC: SettingViewController = SettingViewController()
        self.navigationController?.pushViewController(secondVC, animated: true)
    }

    func weatherScreenView() {
        print("weatherScreenView")
        self.navigationController!.setNavigationBarHidden(true, animated: false) // ナビゲーションバーを非表示に設定
        self.view.backgroundColor = UIColor(named: "skyblue")

        // MARK: 背景の雲の表示設定
        let backImage = UIImage(named: "cloud_background")
        var backImageView = UIImageView(frame: CGRect(x: view.frame.width * -0.4, y: view.frame.height * 0.6, width: 400, height: 160))
        backImageView.image = backImage
        self.view.addSubview(backImageView)
        backImageView = UIImageView(frame: CGRect(x: view.frame.width * 0.5, y: view.frame.height * 0.8, width: 270, height: 110))
        backImageView.image = backImage
        self.view.addSubview(backImageView)

        // MARK: 設定ボタンの表示設定
        let settingButton = UIButton(frame: CGRect(x: view.frame.width * 0.5, y: view.frame.height * 0.05, width: 200, height: 80))
        settingButton.setTitle("設定", for: UIControl.State.normal)
        settingButton.setTitleColor(UIColor(named: "textGray"), for: UIControl.State.normal)
        settingButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        settingButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20) // 右に余白を入れてタイトルが中央に表示されるよう微調整。
        let settingButtonImage = UIImage(named: "cloud_setting")
        settingButton.setBackgroundImage(settingButtonImage, for: UIControl.State.normal)
        self.view.addSubview(settingButton)
        settingButton.addTarget(self, action: #selector(settingButtonClicked(sender:)), for: UIControl.Event.touchUpInside)

        // MARK: エリアの表示設定（都道府県）
        let areaNameBackImage = UIImage(named: "cloud_area")
        let areaNameBackImageView = UIImageView(frame: CGRect(x: view.frame.width * -0.3, y: view.frame.height * 0.12, width: 360, height: 140))
        areaNameBackImageView.image = areaNameBackImage
        self.view.addSubview(areaNameBackImageView)
        areaNameLabel = UILabel(frame: CGRect(x: areaNameBackImageView.frame.origin.x + 20,
                                              y: areaNameBackImageView.frame.origin.y,
                                              width: areaNameBackImageView.frame.width,
                                              height: areaNameBackImageView.frame.height))
        areaNameLabel.textColor = UIColor(named: "textGray")
        areaNameLabel.font = UIFont.systemFont(ofSize: 35)
        areaNameLabel.textAlignment = NSTextAlignment.center
        areaNameLabel.adjustsFontSizeToFitWidth = true
        self.view.addSubview(areaNameLabel)

        // MARK: 気温の表示設定
        let temperatureBackImage = UIImage(named: "cloud_temp")
        let temperatureBackImageView = UIImageView(frame: CGRect(x: view.frame.width * 0.4, y: view.frame.height * 0.3, width: 300, height: 130))
        temperatureBackImageView.image = temperatureBackImage
        self.view.addSubview(temperatureBackImageView)
        temperatureLabel = UILabel(frame: CGRect(x: temperatureBackImageView.frame.origin.x - 20,
                                                 y: temperatureBackImageView.frame.origin.y - 5,
                                                 width: temperatureBackImageView.frame.width,
                                                 height: temperatureBackImageView.frame.height))
        temperatureLabel.textColor = UIColor(named: "textGray")
        temperatureLabel.font = UIFont.systemFont(ofSize: 35)
        temperatureLabel.textAlignment = NSTextAlignment.center
        temperatureLabel.adjustsFontSizeToFitWidth = true
        self.view.addSubview(temperatureLabel)
    }

    func weatherInfoView(id: String) {
        print("weatherInfoView: id " + id)
        let url: String = "http://weather.livedoor.com/forecast/webservice/json/v1?city=" + id
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                let json: JSON = JSON(response.result.value ?? kill)
                self.areaNameLabel.text = json["location"]["prefecture"].stringValue
                self.temperatureLabel.text = json["forecasts"][self.date]["temperature"]["max"]["celsius"].stringValue + "℃"
                print("weatherInfoView: JSON response [success]")
                print("weatherInfoView: pre " + self.areaNameLabel.text! + ", temp " + self.temperatureLabel.text!)
            case .failure(let error):
                print(error)
            }
        }
    }
}

// ---------------------------------------------------------------------------
// memo
// ---------------------------------------------------------------------------
// Alamofire はREST API のJSONデータを取得してくれる役割
// Alamofire は非同期処理
// SwiftyJSON はJSONデータをJSON型としてswiftの配列として扱えるようにしてくれる役割

/*
 print("JSON型のデータを表示")
 
 print(testJson)
 print(testJson["title"].stringValue)
 print(testJson["description"]["text"].stringValue)
 print()
 print(testJson["location"]["prefecture"].stringValue)
 print(testJson["forecasts"][self.date]["telop"].stringValue)
 print(testJson["forecasts"][self.date]["temperature"]["max"]["celsius"].stringValue) // 最高気温
 print(testJson["forecasts"][self.date]["temperature"]["min"]["celsius"].stringValue) // 最低気温
 */

