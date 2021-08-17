//
//  Images2ViewController.swift
//  SavingArrayInCoreData
//
//  Created by Minju Lee on 2021/08/17.
//

import UIKit

class Images2ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataManager.shared.fetchPost()
        tableView.reloadData()
    }

}

class Images2TableViewCell: UITableViewCell {
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var aromaLabel: UILabel!
}

extension Images2ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if DataManager.shared.postList.count == 0 {
//            return 0
//        } else {
//            return DataManager.shared.postList.count
//        }
        
        return DataManager.shared.postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Images2Cell") as! Images2TableViewCell
        let item = DataManager.shared.postList[indexPath.row]
        let aromas = item.aromas?.joined(separator: ", ")
        cell.placeLabel.text = item.place
        cell.aromaLabel.text = aromas
        
        let imageCount = item.images?.count
        if imageCount == 1 {
            cell.firstImageView.image = item.images?[0]
        } else if imageCount == 2 {
            cell.firstImageView.image = item.images?[0]
            cell.secondImageView.image = item.images?[1]
        } else if imageCount == 3 {
            cell.firstImageView.image = item.images?[0]
            cell.secondImageView.image = item.images?[1]
            cell.thirdImageView.image = item.images?[2]
        } else {
            
        }
  
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
}
