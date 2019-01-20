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
    let tableList: Data!

    init(data: Data) {
        tableList = data
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        subTableView = UITableView()
        subTableView.delegate = self
        subTableView.dataSource = self

        subTableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        subTableView.backgroundColor = UIColor(named: "skyblue")
        subTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(subTableView)
    }

    // MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //テーブルビューのセルの数はmyItems配列の数とした
        return tableList.subList.count
    }

    // MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //myItems配列の中身をテキストにして登録した
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = tableList.subList[indexPath.row].name
        cell.contentView.backgroundColor = UIColor(named: "skyblue")
        return cell
    }

    // MARK: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
        tableView.deselectRow(at: indexPath, animated: true)
        let firstVC = ViewController()
        firstVC.userDefaults.set(tableList.subList[indexPath.row].id, forKey: "KEY_CITY_ID")
        print(tableList.subList[indexPath.row].name)
        print(tableList.subList[indexPath.row].id)
        self.navigationController?.popToRootViewController(animated: true)
    }
}
