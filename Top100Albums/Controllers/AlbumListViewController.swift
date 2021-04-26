//
//  AlbumListViewController.swift
//  Top100Albums
//
//  Created by Surendra Singh on 4/23/21.
//

import UIKit

class AlbumListViewController: UIViewController {

    var tableView:UITableView?
    let cellIdentifier = "cellIdentifier"
    var activity:UIActivityIndicatorView?
    
    var viewModel = AlbumListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.configureActivityView()
        self.fetchFeedData()
    }
    
    func configureActivityView(){
        let activity = UIActivityIndicatorView(style: .large)
        activity.frame = CGRect(origin: .zero, size: CGSize(width: 50, height: 50))
        self.view.addSubview(activity)
        activity.center = self.view.center
        activity.color = .white
        activity.layer.cornerRadius = 5.0
        activity.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.view.bringSubviewToFront(activity)
        self.activity = activity
    }
    
    func configureTableView() {
       
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.estimatedRowHeight = 120
        tableView.tableFooterView = UIView(frame: .zero)
        self.tableView = tableView
        
        self.configureTableViewConstraints()
    }
    
    func configureTableViewConstraints(){
        
        guard let tableView = self.tableView else { return }
        let views: [String: UIView] = [
            "view": self.view,
            "tableView": tableView]
        var allConstraints: [NSLayoutConstraint] = []
        let verticalConstraints = NSLayoutConstraint.constraints(
          withVisualFormat: "V:|-0-[tableView]-0-|",
          metrics: nil,
          views: views)
        allConstraints += verticalConstraints
        
        let horizontalConstraints = NSLayoutConstraint.constraints(
          withVisualFormat: "H:|-0-[tableView]-0-|",
          metrics: nil,
          views: views)
        allConstraints += horizontalConstraints
        NSLayoutConstraint.activate(allConstraints)
    }
    
    
    func fetchFeedData(){
        
        guard let activity = self.activity, let tableView = self.tableView else { return }
        activity.startAnimating()
       
        self.viewModel.fetchAlbum(for: .appleMusic, feedType: .topAlbum, genre: .all) { (error) in
            DispatchQueue.main.async {
                activity.stopAnimating()
                if let error = error {
                    let alert = UIAlertController(title: "Error!", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { (action) in
                        self.fetchFeedData()
                    }))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    if let feed = self.viewModel.getFeed(){
                        self.title = feed.title
                        tableView.reloadData()
                    }
                }
            }
        }
    }
}

extension AlbumListViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        guard let _ = self.viewModel.getFeed() else { return 0 }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.viewModel.getFeedResultsCount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AlbumTableViewCell else {
            return AlbumTableViewCell()
        }
        let result = self.viewModel.getResult(atIndex: indexPath.row)
        cell.album = result
        
        return cell
    }
}


extension AlbumListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailViewController = AlbumDetailViewController()
        let result = self.viewModel.getResult(atIndex: indexPath.row)

        detailViewController.album = result
        guard let navigationController =  self.navigationController else {return}
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
