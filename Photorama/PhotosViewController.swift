//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Hemant Phutela on 14/03/2019.
//  Copyright © 2019 Hemant Phutela. All rights reserved.
//

import UIKit
class PhotosViewController: UIViewController, UICollectionViewDelegate {
   // @IBOutlet var imageView: UIImageView!
   // @IBOutlet var imageView: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    
    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        store.fetchInterestingPhotos{
            (PhotosResult) -> Void in
            
            switch PhotosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos.")
                
//                if let firstPhoto = photos.first {
//                    self.updateImageView(for: firstPhoto)
//                }
                self.photoDataSource.photos = photos
            case let .failure(error):
                print("Error fetching interesting photos: \(error)")
                self.photoDataSource.photos.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
//    func updateImageView(for photo: Photo) {
//        store.fetchImage(for: photo) {
//            (imageResult) -> Void in
//
//            switch imageResult {
//            case let .success(image):
//                self.imageView.image = image
//            case let .failure(error):
//                print("Error downloading image: \(error)")
//            }
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        
        store.fetchImage(for: photo) { (result) -> Void in
            
            guard let photoIndex = self.photoDataSource.photos.index(of: photo),
                case let .success(image) = result else {
                    return
            }
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            
            if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell{
                cell.update(with: image)
            }
        }
    }
}
