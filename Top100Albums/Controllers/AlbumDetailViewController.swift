//
//  AlbumDetailViewController.swift
//  Top100Albums
//
//  Created by Surendra Singh on 4/23/21.
//

import Foundation
import UIKit

class AlbumDetailViewController: UIViewController {
   
    var topbarHeight: CGFloat {
        guard let window = view.window, let windowScene = window.windowScene, let statusBarManager = windowScene.statusBarManager else { return 0 }
        
        guard let navigationController = self.navigationController else { return 0 }
        return (statusBarManager.statusBarFrame.height ) +
            (navigationController.navigationBar.frame.height )
        }
    
    
    private let albumImageView:UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleToFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private let authorNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let genreLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let genreListLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let releaseDateLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let copyRightLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let viewAlbumBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Open in iTunes store", for: .normal)
        btn.addTarget(self, action: #selector(AlbumDetailViewController.openUrl), for: .touchUpInside)
        return btn
    }()
    
    var album:Result?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.configureUI()
        self.updateData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.edgesForExtendedLayout = []
    }
    
    
    func configureUI(){
        
        self.view.addSubview(self.albumImageView)
        self.view.addSubview(self.authorNameLabel)
        self.view.addSubview(self.genreLabel)
        self.view.addSubview(self.releaseDateLabel)
        self.view.addSubview(self.copyRightLabel)
        self.view.addSubview(self.viewAlbumBtn)
        self.view.addSubview(self.genreListLabel)
        
        self.configureUIConstraints()
    }
    
    func configureUIConstraints(){
        
        self.albumImageView.translatesAutoresizingMaskIntoConstraints = false
        self.authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.genreLabel.translatesAutoresizingMaskIntoConstraints = false
        self.releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.copyRightLabel.translatesAutoresizingMaskIntoConstraints = false
        self.viewAlbumBtn.translatesAutoresizingMaskIntoConstraints = false
        self.genreListLabel.translatesAutoresizingMaskIntoConstraints = false
        

        let views: [String: UIView] = [
            "view": self.view,
            "albumImageView": self.albumImageView,
            "authorNameLabel": self.authorNameLabel,
            "genreLabel": self.genreLabel,
            "genreListLabel": self.genreListLabel,
            "releaseDateLabel": self.releaseDateLabel,
            "copyRightLabel": self.copyRightLabel,
            "viewAlbumBtn": self.viewAlbumBtn]
        var allConstraints: [NSLayoutConstraint] = []
        
        //AlbumImageView
        let albumImageViewVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-\(self.topbarHeight + 10)-[albumImageView(==\(UIScreen.main.bounds.width - 20))]",
            metrics: nil,
            views: views)
        allConstraints += albumImageViewVerticalConstraints
        
        let albumImageViewHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[albumImageView]-10-|",
            metrics: nil,
            views: views)
        allConstraints += albumImageViewHorizontalConstraints
        
        
        //AuthorNameLabel
        let authorNameLabelVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[albumImageView]-10-[authorNameLabel(==20)]",
            metrics: nil,
            views: views)
        allConstraints += authorNameLabelVerticalConstraints
        
        let authorNameLabelHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[authorNameLabel]-10-|",
            metrics: nil,
            views: views)
        allConstraints += authorNameLabelHorizontalConstraints
        
        //GenreLabel
        let genreLabelVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[authorNameLabel]-0-[genreLabel(==20)]",
            metrics: nil,
            views: views)
        allConstraints += genreLabelVerticalConstraints
        
        let genreLabelHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[genreLabel]-10-|",
            metrics: nil,
            views: views)
        allConstraints += genreLabelHorizontalConstraints
        
        
        //GenreListLabel
        let genreListLabelVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[genreLabel]-0-[genreListLabel(>=20)]",
            metrics: nil,
            views: views)
        allConstraints += genreListLabelVerticalConstraints
        
        let genreListLabelHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-15-[genreListLabel]-10-|",
            metrics: nil,
            views: views)
        allConstraints += genreListLabelHorizontalConstraints
        
        //ReleaseDateLabel
        let releaseDateLabelVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[genreListLabel]-0-[releaseDateLabel(==20)]",
            metrics: nil,
            views: views)
        allConstraints += releaseDateLabelVerticalConstraints
        
        let releaseDateLabelHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[releaseDateLabel]-10-|",
            metrics: nil,
            views: views)
        allConstraints += releaseDateLabelHorizontalConstraints
        
        
        //CopyRightLabel
        let copyRightLabelVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[releaseDateLabel]-0-[copyRightLabel(>=20)]",
            metrics: nil,
            views: views)
        allConstraints += copyRightLabelVerticalConstraints
        
        let copyRightLabelHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[copyRightLabel]-10-|",
            metrics: nil,
            views: views)
        allConstraints += copyRightLabelHorizontalConstraints
        
        //ViewOnBtn
        let viewOnBtnVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[viewAlbumBtn(==44)]-20-|",
            metrics: nil,
            views: views)
        allConstraints += viewOnBtnVerticalConstraints
        
        let viewOnBtnHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-20-[viewAlbumBtn]-20-|",
            metrics: nil,
            views: views)
        allConstraints += viewOnBtnHorizontalConstraints
        NSLayoutConstraint.activate(allConstraints)
    }
    
    func updateData(){
        guard let album =  self.album else { return }
        self.title = album.name
        self.authorNameLabel.text = "Artist Name : \(album.artistName)"
        self.releaseDateLabel.text = "Release date : \(album.releaseDate)"
        self.copyRightLabel.text = "Copyright : \(album.copyright)"
        self.genreLabel.text = "Genres : "
        self.genreListLabel.attributedText = self.createGenreList(genreList: album.genres)
        
        if let url = URL(string: album.artworkUrl100) {
            let imageStore = ImageStore.sharedImageStore
            imageStore.getImage(forUrl: url) { (image) in
                DispatchQueue.main.async {
                self.albumImageView.image = image
                }
            }}else{
                self.albumImageView.image = UIImage(named: Constants.kNoImageKey.rawValue)
            }
    }
    
    @objc func openUrl(){
        guard let album =  self.album else { return }
        if let url  = URL(string: album.url),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func createGenreList(genreList: [Genre]) -> NSAttributedString {

        let font = UIFont.systemFont(ofSize: 14)
        let identation:CGFloat = 20.0
        let textAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.black]
        let bulletAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.black]

        let paragraphStyle = NSMutableParagraphStyle()
        let nonOptions = [NSTextTab.OptionKey: Any]()
        paragraphStyle.tabStops = [
            NSTextTab(textAlignment: .left, location: identation, options: nonOptions)]
        paragraphStyle.defaultTabInterval = identation
        paragraphStyle.lineSpacing = 2
        paragraphStyle.paragraphSpacing = 2
        paragraphStyle.headIndent = identation

        let bulletList = NSMutableAttributedString()
        var counter = 0
        for genre in genreList {
            counter = counter + 1
            let formattedString = "\(counter).\t\(genre.name)\n"
            let attributedString = NSMutableAttributedString(string: formattedString)

            attributedString.addAttributes(
                [NSAttributedString.Key.paragraphStyle : paragraphStyle],
                range: NSMakeRange(0, attributedString.length))

            attributedString.addAttributes(
                textAttributes,
                range: NSMakeRange(0, attributedString.length))

            let string:NSString = NSString(string: formattedString)
            let rangeForBullet:NSRange = string.range(of: "\(counter)")
            attributedString.addAttributes(bulletAttributes, range: rangeForBullet)
            bulletList.append(attributedString)
        }

        return bulletList
    }
}
