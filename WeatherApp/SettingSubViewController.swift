//
//  SettingSubViewController.swift
//  WeatherApp
//
//  Created by 早坂甫 on 2019/01/20.
//  Copyright © 2019年 早坂甫. All rights reserved.
//

import UIKit

class SettingSubViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var subTableView: UITableView!
    var tableList: Data!
    var backImageCloud: ImageView!
    var backButton: ButtonView!

    init(data: Data) {
        super.init(nibName: nil, bundle: nil)
        tableList = data
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(named: "skyblue")

        // 背景用の雲を表示
        backImageCloud = ImageView(frame: CGRect(x: view.frame.width * 0.5, y: view.frame.height * 0.2, width: 380, height: 140))
        backImageCloud.imageView.image = UIImage(named: "cloud_background")
        self.view.addSubview(backImageCloud)

        backImageCloud = ImageView(frame: CGRect(x: view.frame.width * -0.4, y: view.frame.height * 0.4, width: 380, height: 140))
        backImageCloud.imageView.image = UIImage(named: "cloud_background")
        self.view.addSubview(backImageCloud)

        backImageCloud = ImageView(frame: CGRect(x: view.frame.width * 0.4, y: view.frame.height * 0.6, width: 340, height: 120))
        backImageCloud.imageView.image = UIImage(named: "cloud_temp")
        self.view.addSubview(backImageCloud)

        backImageCloud = ImageView(frame: CGRect(x: view.frame.width * -0.2, y: view.frame.height * 0.8, width: 300, height: 120))
        backImageCloud.imageView.image = UIImage(named: "cloud_temp")
        self.view.addSubview(backImageCloud)

        // 閉じるボタン表示
        backButton = ButtonView(image: "cloud_setting", name: "戻る",
                                frame: CGRect(x: view.frame.width * 0.05, y: view.frame.height * 0.05, width: 200, height: 80))
        backButton.labelFrame = CGRect(x: 65, y: 30, width: 50, height: 25)
        self.view.addSubview(backButton)
        backButton.button.addTarget(self, action: #selector(backButtonClicked(sender:)), for: UIControl.Event.touchUpInside)

        // テーブルビュー表示
        subTableView = UITableView()
        subTableView.delegate = self
        subTableView.dataSource = self

        subTableView.frame = CGRect(x: 0, y: 120, width: view.frame.width, height: view.frame.height - 120)
        subTableView.backgroundColor = UIColor.clear
        subTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(subTableView)
    }

    // MARK: 閉じるボタン押下処理
    @objc func backButtonClicked(sender: UIButton) {
        print("backButtonClicked")
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableList.subList.count
    }

    // MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = tableList.subList[indexPath.row].name
        cell.textLabel?.textColor = UIColor(named: "textGray")
        cell.backgroundColor = UIColor.clear
        return cell
    }

    // MARK: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
        tableView.deselectRow(at: indexPath, animated: true)
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.navigationController?.view.layer.add(transition, forKey: nil)
        let firstVC = ViewController()
        firstVC.userDefaults.set(tableList.subList[indexPath.row].id, forKey: "KEY_CITY_ID")
        print(tableList.subList[indexPath.row].name)
        print(tableList.subList[indexPath.row].id)
        self.navigationController?.popToRootViewController(animated: true)
    }
}
