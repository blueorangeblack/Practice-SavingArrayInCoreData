//
//  ViewController.swift
//  SavingArrayInCoreData
//
//  Created by Minju Lee on 2021/08/16.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var aromasLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var imageView0: UIImageView!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        imageView0.image = UIImage(named: "fruit0")
//        imageView1.image = UIImage(named: "fruit1")
//        let aromaArray: [String] = ["커피","코코넛"]
//        let place = "홍대"
//        let images: [UIImage] = [imageView0.image!, imageView1.image!]
//        DataManager.shared.addPost(aromas: aromaArray, place: place, images: images)
    }

    @IBAction func fetchButtonTapped(_ sender: UIButton) {
        DataManager.shared.fetchPost()
        let list = DataManager.shared.postList
        if let aromas = list.first?.aromas {
            let string = aromas.joined(separator: "\n")
            aromasLabel.text = string
        }
        
        placeLabel.text = list.first?.place
        
        imageView2.image = list.first?.images?.first
        imageView3.image = list.first?.images?.last
    }
}
