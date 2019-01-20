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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController!.setNavigationBarHidden(false, animated: false)

        initTableList()

        settingTableView = UITableView()
        settingTableView.delegate = self
        settingTableView.dataSource = self

        settingTableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        settingTableView.backgroundColor = UIColor(named: "skyblue")
        settingTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(settingTableView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.setNavigationBarHidden(false, animated: false)
    }

    // MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //テーブルビューのセルの数はmyItems配列の数とした
        return self.tableList.count
    }

    // MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //myItems配列の中身をテキストにして登録した
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = self.tableList[indexPath.row].area
        cell.contentView.backgroundColor = UIColor(named: "skyblue")
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

        // 宮城県
        data = Data()
        data.area = "宮城県"
        data.setSubData(name: "仙台", id: "040010")
        data.setSubData(name: "白石", id: "040020")
        tableList.append(data)

        // 山形県
        data = Data()
        data.area = "山形県"
        data.setSubData(name: "山形", id: "060010")
        data.setSubData(name: "米沢", id: "060020")
        data.setSubData(name: "酒田", id: "060030")
        data.setSubData(name: "新庄", id: "060040")
        tableList.append(data)

        // 埼玉県
        data = Data()
        data.area = "埼玉県"
        data.setSubData(name: "さいたま", id: "110010")
        data.setSubData(name: "熊谷", id: "110020")
        data.setSubData(name: "秩父", id: "110030")
        tableList.append(data)

        // 東京都
        data = Data()
        data.area = "東京都"
        data.setSubData(name: "東京", id: "130010")
        data.setSubData(name: "大島", id: "130020")
        data.setSubData(name: "八丈島", id: "130030")
        data.setSubData(name: "父島", id: "130040")
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
