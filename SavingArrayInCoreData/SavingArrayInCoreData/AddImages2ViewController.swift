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
    
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var aromasAndFlavorsTextField: UITextField!
    
    var selectedImages = [UIImage]()
    var selectedAromasAndFlavors = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        //config.library.preselectedItems = selectedItems
        
        let picker = YPImagePicker(configuration: config)
        picker.imagePickerDelegate = self
        
        picker.didFinishPicking { [weak picker] items, cancelled in

            if cancelled {
                print("Picker was canceled")
                picker?.dismiss(animated: true, completion: nil)
                return
            }
            //_ = items.map { print("🧀 \($0)") }

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
                        //print("갯수 : \(selectedItems.count)")
                    })
                case .video:
//                    self.selectedImageV.image = video.thumbnail
//
//                    let assetURL = video.url
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
        self.selectedAromasAndFlavors.append(self.aromasAndFlavorsTextField.text ?? "")
    }
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        DataManager.shared.addPost(aromas: selectedAromasAndFlavors, place: placeTextField.text ?? "", images: selectedImages)
        dismiss(animated: true, completion: nil)
    }
}
