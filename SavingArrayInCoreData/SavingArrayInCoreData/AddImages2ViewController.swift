//
//  AddImages2ViewController.swift
//  SavingArrayInCoreData
//
//  Created by Minju Lee on 2021/08/17.
//

import UIKit
import YPImagePicker

class AddImages2ViewController: UIViewController, YPImagePickerDelegate {
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var aromasAndFlavorsTextField: UITextField!
    @IBOutlet weak var alcoholContentTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var ratingSegmentedControl: UISegmentedControl!
    
    var selectedImages: [UIImage]?
    var selectedAromasAndFlavors: [String]?
    var price: Int32?
    var alcoholContent: Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addImageButtonTapped(_ sender: UIButton) {
        
        var config = YPImagePickerConfiguration()
        config.library.mediaType = .photo
        config.library.itemOverlayType = .grid
        config.usesFrontCamera = false
        config.shouldSaveNewPicturesToAlbum = false
        config.startOnScreen = .library
        config.screens = [.library, .photo]
        //config.showsCrop = .rectangle(ratio: (16/9))
        config.wordings.libraryTitle = "Gallery"
        config.hidesStatusBar = false
        config.hidesBottomBar = false

        config.maxCameraZoomFactor = 2.0

        config.library.maxNumberOfItems = 3
        config.gallery.hidesRemoveButton = false
        
        let picker = YPImagePicker(configuration: config)
        picker.imagePickerDelegate = self
        
        picker.didFinishPicking { [weak picker] items, cancelled in

            if cancelled {
                print("Picker was canceled")
                picker?.dismiss(animated: true, completion: nil)
                return
            }

            var selectedItems = [UIImage]()
            
           for item in items {
                switch item {
                case .photo(let photo):
                    
                    selectedItems.append(photo.image)
                    let count = selectedItems.count
                    if count == 1 {
                        self.firstImageView.image = selectedItems[0]
                        self.secondImageView.image = nil
                        self.thirdImageView.image = nil
                    } else if count == 2 {
                        self.firstImageView.image = selectedItems[0]
                        self.secondImageView.image = selectedItems[1]
                        self.thirdImageView.image = nil
                    } else if count == 3 {
                        self.firstImageView.image = selectedItems[0]
                        self.secondImageView.image = selectedItems[1]
                        self.thirdImageView.image = selectedItems[2]
                    } else {
                        return
                    }
                    picker?.dismiss(animated: true, completion: {
                        self.selectedImages = selectedItems
                    })
                case .video:
                    print("video")
                }
            }
        }
        present(picker, animated: true, completion: nil)
    }
    
    func noPhotos() {
        print("noPhotos")
    }
    
    func shouldAddToSelection(indexPath: IndexPath, numSelections: Int) -> Bool {
        return true
    }
    
    @IBAction func addAromasAndFlavorsButtonTapped(_ sender: UIButton) {
        //self.selectedAromasAndFlavors.append(self.aromasAndFlavorsTextField.text ?? "")
        self.selectedAromasAndFlavors = ["레몬","사과","코코넛","토스트"]
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let date = datePicker.date
        let place = placeTextField.text
        if let alcoholContentString = alcoholContentTextField.text {
            if let a = Float(alcoholContentString) {
                alcoholContent = a
            } else {
                print("알코올 도수 입력 오류")
            }
        }
        if let priceString = priceTextField.text {
            if let p = Int32(priceString) {
                price = p
            } else {
                print("가격 입력 오류")
            }
        }
        let rating = ratingSegmentedControl.selectedSegmentIndex + 1
       
        let wineTastingNotes = WineTastingNotes(date: date, place: place, image: selectedImages, price: price ?? 0, alcoholContent: alcoholContent ?? 0, aromasAndFlavors: selectedAromasAndFlavors, rating: Int16(rating))
        
        DataManager.shared.addPost(wineTastingNotes: wineTastingNotes)
//        dismiss(animated: true, completion: nil)
        dismiss(animated: true) {
            self.selectedImages = nil
        }
    }
}
