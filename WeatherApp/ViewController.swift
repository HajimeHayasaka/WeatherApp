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
    var alertTitle: String!
    var alertMessage: String!
    var temperatureView: ImageView!
    var areaNameView: ImageView!
    var telopImageView: ImageView!
    var backImageCloud_1: ImageView!
    var backImageCloud_2: ImageView!
    var settingButton: ButtonView!
    var detailButton: ButtonView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // ユーザーデータの初期値をセット
        userDefaults.register(defaults: ["KEY_CITY_ID": "040010"])

        // ナビゲーションバーを非表示に設定
        self.navigationController!.setNavigationBarHidden(true, animated: false)

        self.view.backgroundColor = UIColor(named: "skyblue")

        // 背景用の雲を表示（その１）
        backImageCloud_1 = ImageView(frame: CGRect(x: view.frame.width * -0.4, y: view.frame.height * 0.6, width: 400, height: 160))
        backImageCloud_1.imageView.image = UIImage(named: "cloud_background")
        self.view.addSubview(backImageCloud_1)

        // 背景用の雲を表示（その２）
        backImageCloud_2 = ImageView(frame: CGRect(x: view.frame.width * 0.5, y: view.frame.height * 0.8, width: 270, height: 110))
        backImageCloud_2.imageView.image = UIImage(named: "cloud_background")
        self.view.addSubview(backImageCloud_2)

        // 設定ボタン表示
        settingButton = ButtonView(image: "cloud_setting", name: "設定",
                                   frame: CGRect(x: view.frame.width * 0.5, y: view.frame.height * 0.05, width: 200, height: 80))
        settingButton.labelFrame = CGRect(x: 65, y: 30, width: 50, height: 25)
        self.view.addSubview(settingButton)
        settingButton.button.addTarget(self, action: #selector(settingButtonClicked(sender:)), for: UIControl.Event.touchUpInside)

        // 詳細ボタン表示
        detailButton = ButtonView(image: "cloud_setting", name: "詳細",
                                  frame: CGRect(x: view.frame.width * 0.1, y: view.frame.height * 0.4, width: 130, height: 60))
        detailButton.labelFrame = CGRect(x: 35, y: 20, width: 50, height: 25)
        self.view.addSubview(detailButton)
        detailButton.button.addTarget(self, action: #selector(detailButtonClicked(sender:)), for: UIControl.Event.touchUpInside)

        // 気温表示枠を配置
        temperatureView = ImageView(image: "cloud_temp",
                                    frameOfImage: CGRect(x: view.frame.width * 0.4, y: view.frame.height * 0.3, width: 300, height: 130),
                                    text: "---",
                                    frameOfLabel: CGRect(x: 60, y: 50, width: 150, height: 30))
        self.view.addSubview(temperatureView)

        // 都道府県（エリア）表示枠を配置
        areaNameView = ImageView(image: "cloud_area",
                                 frameOfImage: CGRect(x: view.frame.width * -0.3, y: view.frame.height * 0.12, width: 360, height: 140),
                                 text: "---",
                                 frameOfLabel: CGRect(x: 135, y: 60, width: 140, height: 35))
        self.view.addSubview(areaNameView)

        // 天気のイラスト表示枠を配置
        telopImageView = ImageView(frame: CGRect(x: view.frame.width * 0.1, y: view.frame.height * 0.5, width: 300, height: 300))
        self.view.addSubview(telopImageView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")

        // お天気情報を表示（地域と気温とイラストを表示）
        weatherInfoView(id: userDefaults.integer(forKey: "KEY_CITY_ID"))
    }

    // MARK: 設定ボタン押下処理
    @objc func settingButtonClicked(sender: UIButton) {
        print("settingButtonClicked")
        let secondVC: SettingViewController = SettingViewController()
        self.navigationController?.pushViewController(secondVC, animated: true)
    }

    // MARK: 詳細ボタン押下処理
    @objc func detailButtonClicked(sender: UIButton) {
        print("detailButtonClicked")
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: お天気情報を表示（地域と気温とイラストを表示）
    func weatherInfoView(id: Int) {
        print("weatherInfoView: id " + "\(id)")
        let url: String = "http://weather.livedoor.com/forecast/webservice/json/v1?city=" + "\(id)"
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                let json: JSON = JSON(response.result.value ?? kill)
                self.areaNameView.label.text = json["location"]["prefecture"].stringValue + "/" + json["location"]["city"].stringValue
                var temperatureJson = json["forecasts"][self.date]["temperature"]
                self.temperatureView.label.text = temperatureJson["max"]["celsius"].stringValue + "℃/" +
                                                  temperatureJson["min"]["celsius"].stringValue + "℃"
                switch json["forecasts"][self.date]["telop"].stringValue.prefix(1) {
                case "晴":
                    self.telopImageView.imageView.image = UIImage(named: "sunny")
                case "曇":
                    self.telopImageView.imageView.image = UIImage(named: "cloudiness")
                case "雪":
                    self.telopImageView.imageView.image = UIImage(named: "snow")
                default:
                    break
                }
                self.alertTitle = json["title"].stringValue
                self.alertMessage = json["description"]["text"].stringValue
                print(json)
                print("weatherInfoView: JSON response [success]")
                print("weatherInfoView: pre " + self.areaNameView.label.text! + ", temp " + self.temperatureView.label.text! + ", telop " + json["forecasts"][self.date]["telop"].stringValue.prefix(1))
            case .failure(let error):
                print(error)
            }
        }
    }
}

