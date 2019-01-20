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

        initTableList()

        settingTableView = UITableView()
        settingTableView.delegate = self
        settingTableView.dataSource = self

        settingTableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        settingTableView.backgroundColor = UIColor(named: "skyblue")
        settingTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(settingTableView)
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
        // 宮城県
        var data = Data()
        data.area = "宮城県"
        data.setSubData(name: "仙台", id: "040010")
        data.setSubData(name: "白石", id: "040020")
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
    }
}
