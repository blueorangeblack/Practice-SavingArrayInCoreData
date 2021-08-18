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
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var aromaLabel: UILabel!
    @IBOutlet weak var alcoholContentLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
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
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "KO_KR")
        let date = formatter.string(from: item.date!)
        cell.dateLabel.text = date
        cell.placeLabel.text = item.place
        let aromas = item.aromasAndFlavors?.joined(separator: ", ")
        cell.aromaLabel.text = aromas
        cell.alcoholContentLabel.text = String(item.alcoholContent)
        cell.priceLabel.text = String(item.price)
        cell.ratingLabel.text = String(item.rating)

        let imageCount = item.image?.count
        if imageCount == 1 {
            cell.firstImageView.image = item.image?[0]
        } else if imageCount == 2 {
            cell.firstImageView.image = item.image?[0]
            cell.secondImageView.image = item.image?[1]
        } else if imageCount == 3 {
            cell.firstImageView.image = item.image?[0]
            cell.secondImageView.image = item.image?[1]
            cell.thirdImageView.image = item.image?[2]
        } else {

        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
}
