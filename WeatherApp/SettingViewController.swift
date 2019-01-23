//
//  SettingViewController.swift
//  WeatherApp
//
//  Created by 早坂甫 on 2019/01/14.
//  Copyright © 2019年 早坂甫. All rights reserved.
//

import UIKit

class Data {
    var area: String!
    var subList: Array<SubArea> = []

    struct SubArea {
        var name: String!
        var id: String!
    }

    func setSubData(name: String, id: String) {
        var subArea = SubArea()
        subArea.name = name
        subArea.id = id
        subList.append(subArea)
    }
}

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var settingTableView: UITableView!
    var tableList: Array<Data> = []
    var backImageCloud: ImageView!
    var closeButton: ButtonView!

    override func viewDidLoad() {
        super.viewDidLoad()

        initTableList()

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
        closeButton = ButtonView(image: "cloud_setting", name: "閉じる",
                                   frame: CGRect(x: view.frame.width * 0.05, y: view.frame.height * 0.05, width: 200, height: 80))
        closeButton.labelFrame = CGRect(x: 55, y: 30, width: 70, height: 25)
        self.view.addSubview(closeButton)
        closeButton.button.addTarget(self, action: #selector(closeButtonClicked(sender:)), for: UIControl.Event.touchUpInside)

        // テーブルビュー表示
        settingTableView = UITableView()
        settingTableView.delegate = self
        settingTableView.dataSource = self

        settingTableView.frame = CGRect(x: 0, y: 120, width: view.frame.width, height: view.frame.height - 120)
        settingTableView.backgroundColor = UIColor.clear
        settingTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(settingTableView)
    }

    // MARK: 閉じるボタン押下処理
    @objc func closeButtonClicked(sender: UIButton) {
        print("closeButtonClicked")
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableList.count
    }

    // MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = self.tableList[indexPath.row].area
        cell.textLabel?.textColor = UIColor(named: "textGray")
        cell.backgroundColor = UIColor.clear
        return cell
    }

    // MARK: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
        tableView.deselectRow(at: indexPath, animated: true)
        let thirdVC: SettingSubViewController = SettingSubViewController(data: tableList[indexPath.row])
        self.navigationController?.pushViewController(thirdVC, animated: true)

    }

    func initTableList() {
        // 北海道
        var data = Data()
        data.area = "北海道"
        data.setSubData(name: "稚内", id: "011000")
        data.setSubData(name: "旭川", id: "012010")
        data.setSubData(name: "留萌", id: "012020")
        data.setSubData(name: "網走", id: "013010")
        data.setSubData(name: "北見", id: "013020")
        data.setSubData(name: "紋別", id: "013030")
        data.setSubData(name: "根室", id: "014010")
        data.setSubData(name: "釧路", id: "014020")
        data.setSubData(name: "帯広", id: "014030")
        data.setSubData(name: "室蘭", id: "015010")
        data.setSubData(name: "浦河", id: "015020")
        data.setSubData(name: "札幌", id: "016010")
        data.setSubData(name: "岩見沢", id: "016020")
        data.setSubData(name: "倶知安", id: "016030")
        data.setSubData(name: "函館", id: "017010")
        data.setSubData(name: "江差", id: "017020")
        tableList.append(data)

        // 青森県
        data = Data()
        data.area = "青森県"
        data.setSubData(name: "青森", id: "020010")
        data.setSubData(name: "むつ", id: "020020")
        data.setSubData(name: "八戸", id: "020030")
        tableList.append(data)

        // 岩手県
        data = Data()
        data.area = "岩手県"
        data.setSubData(name: "盛岡", id: "030010")
        data.setSubData(name: "宮古", id: "030020")
        data.setSubData(name: "大船渡", id: "030030")
        tableList.append(data)

        // 宮城県
        data = Data()
        data.area = "宮城県"
        data.setSubData(name: "仙台", id: "040010")
        data.setSubData(name: "白石", id: "040020")
        tableList.append(data)

        // 秋田県
        data = Data()
        data.area = "秋田県"
        data.setSubData(name: "秋田", id: "050010")
        data.setSubData(name: "横手", id: "050020")
        tableList.append(data)

        // 山形県
        data = Data()
        data.area = "山形県"
        data.setSubData(name: "山形", id: "060010")
        data.setSubData(name: "米沢", id: "060020")
        data.setSubData(name: "酒田", id: "060030")
        data.setSubData(name: "新庄", id: "060040")
        tableList.append(data)

        // 福島県
        data = Data()
        data.area = "福島県"
        data.setSubData(name: "福島", id: "070010")
        data.setSubData(name: "小名浜", id: "070020")
        data.setSubData(name: "若松", id: "070030")
        tableList.append(data)

        // 茨城県
        data = Data()
        data.area = "茨城県"
        data.setSubData(name: "水戸", id: "080010")
        data.setSubData(name: "土浦", id: "080020")
        tableList.append(data)

        // 栃木県
        data = Data()
        data.area = "栃木県"
        data.setSubData(name: "宇都宮", id: "090010")
        data.setSubData(name: "大田原", id: "090020")
        tableList.append(data)

        // 群馬県
        data = Data()
        data.area = "群馬県"
        data.setSubData(name: "前橋", id: "100010")
        data.setSubData(name: "みなかみ", id: "100020")
        tableList.append(data)

        // 埼玉県
        data = Data()
        data.area = "埼玉県"
        data.setSubData(name: "さいたま", id: "110010")
        data.setSubData(name: "熊谷", id: "110020")
        data.setSubData(name: "秩父", id: "110030")
        tableList.append(data)

        // 千葉県
        data = Data()
        data.area = "千葉県"
        data.setSubData(name: "千葉", id: "120010")
        data.setSubData(name: "銚子", id: "120020")
        data.setSubData(name: "館山", id: "120020")
        tableList.append(data)

        // 東京都
        data = Data()
        data.area = "東京都"
        data.setSubData(name: "東京", id: "130010")
        data.setSubData(name: "大島", id: "130020")
        data.setSubData(name: "八丈島", id: "130030")
        data.setSubData(name: "父島", id: "130040")
        tableList.append(data)

        // 神奈川県
        data = Data()
        data.area = "神奈川県"
        data.setSubData(name: "横浜", id: "140010")
        data.setSubData(name: "小田原", id: "140020")
        tableList.append(data)

        // 新潟県
        data = Data()
        data.area = "新潟県"
        data.setSubData(name: "新潟", id: "150010")
        data.setSubData(name: "長岡", id: "150020")
        data.setSubData(name: "高田", id: "150030")
        data.setSubData(name: "相川", id: "150040")
        tableList.append(data)

        // 沖縄県
        data = Data()
        data.area = "沖縄県"
        data.setSubData(name: "那覇", id: "471010")
        data.setSubData(name: "名護", id: "471020")
        data.setSubData(name: "久米島", id: "471030")
        data.setSubData(name: "南大東", id: "472000")
        data.setSubData(name: "宮古島", id: "473000")
        data.setSubData(name: "石垣島", id: "474010")
        data.setSubData(name: "与那国島", id: "474020")
        tableList.append(data)
    }
}
