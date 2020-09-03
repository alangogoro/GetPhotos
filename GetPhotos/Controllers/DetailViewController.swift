//
//  DetailViewController.swift
//  GetPhotos
//
//  Created by usr on 2020/4/29.
//  Copyright © 2020 usr. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityIndicatorView: UIView!
    
    var photo: Photo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
    }
    
    func setViews() {
        imageView.image = UIImage(systemName: "icloud.slash")
        activityIndicator.startAnimating()
        URLSession.shared.dataTask(with: photo.url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicatorView.removeFromSuperview()
                    self.imageView.image = image
                }
            }
        }.resume()
        
        idLabel.text = "ID: \(photo.id)"
        titleLabel.text = "Title: \(photo.title)"
    }
}
