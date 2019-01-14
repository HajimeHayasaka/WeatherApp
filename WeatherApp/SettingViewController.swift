//
//  SettingViewController.swift
//  WeatherApp
//
//  Created by 早坂甫 on 2019/01/14.
//  Copyright © 2019年 早坂甫. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    var setCityId: String!
    var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white

        tokyoButton()
        saitamaButton()
        miyagiButton()
        setAreaView()
        setCityButton()

    }

    func setAreaView() {
        label = UILabel(frame: CGRect(x: 100, y: 445, width: 200, height: 100))
        label.text = "None"
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
    }

    // 東京設定ボタンを作成（テストコード）
    func tokyoButton() {
        let Button = UIButton()
        Button.setTitle("Tokyo", for: .normal)
        Button.backgroundColor = UIColor.green
        Button.frame = CGRect(x: 100, y: 100, width: 200, height: 100)
        Button.setTitleColor(UIColor(named: "textGray"), for: .normal)
        Button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        Button.layer.cornerRadius = 20
        self.view.addSubview(Button)
        Button.addTarget(self, action: #selector(tokyoButtonClicked(sender:)), for: .touchUpInside)
    }
    // 東京ボタンを押下時の処理（テストコード）
    @objc func tokyoButtonClicked(sender: UIButton) {
        print("tokyoButtonClicked")
        setCityId = "130010"
        label.text = "tokyo " + setCityId
    }

    // 埼玉設定ボタンを作成（テストコード）
    func saitamaButton() {
        let Button = UIButton()
        Button.setTitle("Saitama", for: .normal)
        Button.backgroundColor = UIColor.green
        Button.frame = CGRect(x: 100, y: 220, width: 200, height: 100)
        Button.setTitleColor(UIColor(named: "textGray"), for: .normal)
        Button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        Button.layer.cornerRadius = 20
        self.view.addSubview(Button)
        Button.addTarget(self, action: #selector(saitamaButtonClicked(sender:)), for: .touchUpInside)
    }
    // 埼玉ボタンを押下時の処理（テストコード）
    @objc func saitamaButtonClicked(sender: UIButton) {
        print("saitamaButtonClicked")
        setCityId = "110010"
        label.text = "saitama " + setCityId
    }

    // 宮城設定ボタンを作成（テストコード）
    func miyagiButton() {
        let Button = UIButton()
        Button.setTitle("Miyagi", for: .normal)
        Button.backgroundColor = UIColor.green
        Button.frame = CGRect(x: 100, y: 340, width: 200, height: 100)
        Button.setTitleColor(UIColor(named: "textGray"), for: .normal)
        Button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        Button.layer.cornerRadius = 20
        self.view.addSubview(Button)
        Button.addTarget(self, action: #selector(miyagiButtonClicked(sender:)), for: .touchUpInside)
    }
    // 宮城ボタンを押下時の処理（テストコード）
    @objc func miyagiButtonClicked(sender: UIButton) {
        print("miyagiButtonClicked")
        setCityId = "040010"
        label.text = "miyagi " + setCityId
    }

    // 地域設定ボタンを作成（テストコード）
    func setCityButton() {
        let setCityButton = UIButton()
        setCityButton.backgroundColor = UIColor.blue
        setCityButton.frame = CGRect(x: view.frame.width * 0.25, y: view.frame.height * 0.8,
                                     width: view.frame.width * 0.5, height: view.frame.height * 0.1)
        setCityButton.setTitleColor(UIColor(named: "textGray"), for: .normal)
        setCityButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        setCityButton.layer.cornerRadius = 20
        setCityButton.setTitle("決定", for: .normal)
        self.view.addSubview(setCityButton)
        setCityButton.addTarget(self, action: #selector(setCityButtonClicked(sender:)), for: .touchUpInside)
    }

    // 設定ボタンを押下時の処理（テストコード）
    @objc func setCityButtonClicked(sender: UIButton) {
        // MARK: 閉じるボタンを押された時の処理
        print("closeButtonClicked")
        self.navigationController?.popViewController(animated: true)
        let t = ViewController()
        t.userDefaults.set(setCityId, forKey: "KEY_CITY_ID")
        // self.navigationController?.popToRootViewController(animated: true)
        // self.dismiss(animated: true, completion: nil) // dismiss は自分自身を消す。結果として裏のレイアウトU（前の画面）が表示される。★うまく動かなかった。なぜ？
    }

}
