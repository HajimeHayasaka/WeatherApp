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
    var areaNameLabel: UILabel!
    var temperatureLabel: UILabel!
    var telopImageView: UIImageView!
    var alertTitle: String!
    var alertMessage: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // ユーザーデータの初期値をセット
        userDefaults.register(defaults: ["KEY_CITY_ID": "040010"])

        // お天気情報画面のレイアウトを描画
        weatherScreenView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        weatherInfoView(id: userDefaults.integer(forKey: "KEY_CITY_ID"))

        let temperatureView = TemperatureView()
        temperatureView.imageView.image = UIImage(named: "sunny")
        temperatureView.frame = CGRect(x: 100, y: 300, width: 200, height: 200)
        self.view.addSubview(temperatureView)
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
        let alert = UIAlertController(
            title: alertTitle,
            message: alertMessage,
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: お天気情報画面のレイアウトを描画
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
        // タイトルをやめてラベルで表示する

        // MARK: エリアの表示設定（都道府県）
        let areaNameBackImage = UIImage(named: "cloud_area")
        let areaNameBackImageView = UIImageView(frame: CGRect(x: view.frame.width * -0.3, y: view.frame.height * 0.12, width: 360, height: 140))
        areaNameBackImageView.image = areaNameBackImage
        self.view.addSubview(areaNameBackImageView)
        areaNameLabel = UILabel(frame: CGRect(x: 135, y: 60, width: 140, height: 35))
        areaNameLabel.textColor = UIColor(named: "textGray")
        areaNameLabel.font = UIFont.systemFont(ofSize: 35)
        areaNameLabel.textAlignment = NSTextAlignment.center
        areaNameLabel.adjustsFontSizeToFitWidth = true
        areaNameBackImageView.addSubview(areaNameLabel)

        // MARK: 気温の表示設定
        let temperatureBackImage = UIImage(named: "cloud_temp")
        let temperatureBackImageView = UIImageView(frame: CGRect(x: view.frame.width * 0.4, y: view.frame.height * 0.3, width: 300, height: 130))
        temperatureBackImageView.image = temperatureBackImage
        self.view.addSubview(temperatureBackImageView)
        temperatureLabel = UILabel(frame: CGRect(x: 60, y: 50, width: 150, height: 30))
        temperatureLabel.textColor = UIColor(named: "textGray")
        temperatureLabel.font = UIFont.systemFont(ofSize: 30)
        temperatureLabel.textAlignment = NSTextAlignment.center
        temperatureLabel.adjustsFontSizeToFitWidth = true
        temperatureBackImageView.addSubview(temperatureLabel)

        // MARK: イラストの表示設定
        telopImageView = UIImageView(frame: CGRect(x: view.frame.width * 0.1, y: view.frame.height * 0.5, width: 300, height: 300))
        telopImageView.contentMode = UIView.ContentMode.scaleAspectFit
        self.view.addSubview(telopImageView)

        // MARK: 詳細ボタンの表示設定（お試し追加）
        let detailButton = UIButton(frame: CGRect(x: view.frame.width * 0.1, y: view.frame.height * 0.4, width: 80, height: 50))
        detailButton.setTitle("詳細", for: UIControl.State.normal)
        detailButton.setTitleColor(UIColor(named: "textGray"), for: UIControl.State.normal)
        detailButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        detailButton.backgroundColor = UIColor.white
        detailButton.layer.cornerRadius = 20
        detailButton.layer.borderColor = UIColor.gray.cgColor
        detailButton.layer.borderWidth = 2.0
        self.view.addSubview(detailButton)
        detailButton.addTarget(self, action: #selector(detailButtonClicked(sender:)), for: UIControl.Event.touchUpInside)
    }

    // MARK: お天気情報を表示（地域と気温とイラストを表示）
    func weatherInfoView(id: Int) {
        print("weatherInfoView: id " + "\(id)")
        let url: String = "http://weather.livedoor.com/forecast/webservice/json/v1?city=" + "\(id)"
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                let json: JSON = JSON(response.result.value ?? kill)
                self.areaNameLabel.text = json["location"]["prefecture"].stringValue + "/" + json["location"]["city"].stringValue
                let temperatureJson = json["forecasts"][self.date]["temperature"]
                self.temperatureLabel.text = temperatureJson["max"]["celsius"].stringValue + "℃/" +
                                             temperatureJson["min"]["celsius"].stringValue + "℃"
                switch json["forecasts"][self.date]["telop"].stringValue.prefix(1) {
                case "晴":
                    self.telopImageView.image = UIImage(named: "sunny")
                case "曇":
                    self.telopImageView.image = UIImage(named: "cloudiness")
                case "雪":
                    self.telopImageView.image = UIImage(named: "snow")
                default:
                    break
                }
                self.alertTitle = json["title"].stringValue
                self.alertMessage = json["description"]["text"].stringValue
                print(json)
                print("weatherInfoView: JSON response [success]")
                print("weatherInfoView: pre " + self.areaNameLabel.text! + ", temp " + self.temperatureLabel.text! + ", telop " + json["forecasts"][self.date]["telop"].stringValue.prefix(1))
            case .failure(let error):
                print(error)
            }
        }
    }
}

