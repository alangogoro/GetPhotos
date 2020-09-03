//
//  PhotoCollectionViewCell.swift
//  GetPhotos
//
//  Created by usr on 2020/4/28.
//  Copyright © 2020 usr. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
        
    /* 當 Storyboard 裡的 Cell 產生時
     * 會先呼叫 function awakeFromNib() */
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 使用 PhotoCollectionViewController 類別的類型屬性 width 做 Constraint
        widthConstraint.constant = PhotoCollectionViewController.width
        
    }
    
    func update(with photo: Photo) {
        idLabel.text = "\(photo.id)"
        titleLabel.text = photo.title
        
        /* 從暫存檔案目錄尋找圖片，沒有圖片則重新抓取 */
        let url = photo.thumbnailUrl
        let tempDirectory = FileManager.default.temporaryDirectory
        let imageFileUrl = tempDirectory.appendingPathComponent(url.lastPathComponent)
        if FileManager.default.fileExists(atPath: imageFileUrl.path) {
            let image = UIImage(contentsOfFile: imageFileUrl.path)
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        } else {
            imageView.image = UIImage(systemName: "icloud.slash")
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    try? data.write(to: imageFileUrl)
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }.resume()
        }
    }
}
