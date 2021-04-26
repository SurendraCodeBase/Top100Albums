//
//  AlbumTableViewCell.swift
//  Top100Albums
//
//  Created by Surendra Singh on 4/23/21.
//

import Foundation
import UIKit

class AlbumTableViewCell : UITableViewCell {
    
    private let albumImageView:UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleToFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private let albumNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let authorNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .left
        return lbl
    }()
    
    var album:Result?{
        didSet{
            self.updateData()
        }
    }
    
    func updateData(){
        guard let album =  self.album else { return }
        self.albumNameLabel.text = album.name
        self.authorNameLabel.text = album.artistName
        let concurrentQueue = DispatchQueue(label: "queuename", attributes: .concurrent)
        concurrentQueue.async {
            self.imageViewConfiguration(album: album)
        }
    }
    
    func imageViewConfiguration(album:Result){
        if let url = URL(string: album.artworkUrl100) {
            let imageStore = ImageStore.sharedImageStore
            imageStore.getImage(forUrl: url) { (image) in
                DispatchQueue.main.async {
                    self.albumImageView.image = image
                }
            }
        }else{
            DispatchQueue.main.async {
                self.albumImageView.image = UIImage(named: Constants.kNoImageKey.rawValue)
            }
        }
    }
    
    func configureConstraints(){
        
        self.albumImageView.translatesAutoresizingMaskIntoConstraints = false
        self.albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String: UIView] = [
            "albumImageView": self.albumImageView,
            "albumNameLabel": self.albumNameLabel,
            "authorNameLabel": self.authorNameLabel]
        var allConstraints: [NSLayoutConstraint] = []
        
        //AlbumImageView
        let albumImageViewVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-5-[albumImageView(==100)]-5-|",
            metrics: nil,
            views: views)
        allConstraints += albumImageViewVerticalConstraints
        
        let albumImageViewHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-5-[albumImageView(==100)]-5-[albumNameLabel(>=0)]-20-|",
            metrics: nil,
            views: views)
        allConstraints += albumImageViewHorizontalConstraints
        
        
        //AlbumNameLabel
        let albumNameLabelVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-5-[albumNameLabel(==60)]-0-[authorNameLabel(>=0)]-5-|",
            metrics: nil,
            views: views)
        allConstraints += albumNameLabelVerticalConstraints
        
        
        let authorNameLabelHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:[albumImageView]-5-[authorNameLabel(>=0)]-20-|",
            metrics: nil,
            views: views)
        allConstraints += authorNameLabelHorizontalConstraints
        NSLayoutConstraint.activate(allConstraints)
    }
    func configureUI(){
        
        self.accessoryType = .disclosureIndicator
        self.addSubview(self.albumImageView)
        self.addSubview(self.albumNameLabel)
        self.addSubview(self.authorNameLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
        self.configureConstraints()
    }
}


