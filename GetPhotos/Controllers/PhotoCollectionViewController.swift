//
//  PhotoCollectionViewController.swift
//  GetPhotos
//
//  Created by usr on 2020/4/28.
//  Copyright © 2020 usr. All rights reserved.
//

import UIKit

class PhotoCollectionViewController: UICollectionViewController {
    
    var photos = [Photo]()
    
    // 取得螢幕的寬，並將之÷4
    /* 類型屬性 Type Property，生命期幾乎和 App 一樣長
     * 不需實例化物件，就能存取該屬性（呼叫 ViewController.property） */
    static let width = floor(UIScreen.main.bounds.width / 4)
    
    private let reuseIdentifier = "PhotoCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PhotoController.shared.fetchPhotos { photos in
            if photos != nil {
                /* 5000筆資料量太大，用 dropLast 去除後面資料 */
                self.photos = photos!.dropLast(4000)
                print("photos.count = \(self.photos.count)")
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Navigation
    /* 換頁並指派資料 */
    @IBSegueAction func showDetail(_ coder: NSCoder) -> DetailViewController? {
        
        /* collectionView.indexPathsForSelectedItems
         * 的資料型態如 [[section, row]] */
        if let cellId = collectionView.indexPathsForSelectedItems?.first?.row,
           let controller = DetailViewController(coder: coder) {
            controller.photo = photos[cellId]
            return controller
        } else {
            return nil
        }
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell
        else { return UICollectionViewCell() }
        
        let photo = photos[indexPath.row]
        cell.update(with: photo)
        return cell
    }
}
