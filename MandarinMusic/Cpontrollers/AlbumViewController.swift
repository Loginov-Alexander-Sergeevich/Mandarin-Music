//
//  AlbumViewController.swift
//  MandarinMusic
//
//  Created by Александр Александров on 20.12.2021.
//

import Foundation
import UIKit
import Moya

class AlbumViewController: UIViewController {

    let provider = MoyaProvider<AlbumItunesAPI>()
    
    var resultsRequestAlbums: [ResultsAlbums] = []
    
    var timer: Timer?
    
    lazy var searchController: UISearchController = {
        let search = UISearchController()
        search.searchBar.delegate = self
        return search
    }()
    
    
    lazy var albumTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(AlbunViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAlbums(albumName: "Arya")
        albumTableView.reloadData()
        configurationConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Albums"
        navigationItem.searchController = searchController
    }
}

extension AlbumViewController {
    
    func configurationConstraints() {
        view.addSubview(albumTableView)
        albumTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func getAlbums(albumName: String) {

        provider.request(.search(path: albumName)) { [unowned self] result in
            
            switch result {
            case .success(let response):
                do {
                    //self.resultsRequestAlbums  = try response.map(RequestAlbums.self).results
                    let resp = try response.map(Albums.self).results?.sorted(by: { firstItem, secondItem in
                        return firstItem.collectionName?.compare(secondItem.collectionName!) == ComparisonResult.orderedAscending
                    })
                    self.resultsRequestAlbums.append(contentsOf: resp!)
                    self.albumTableView.reloadData()
                } catch {
                    print("")
                }
            case .failure(_):
                print("Error jsone request")
            }
        }
    }
}

extension AlbumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsRequestAlbums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AlbunViewCell
        let albums = resultsRequestAlbums[indexPath.row]
        cell.configurationContent(albums)
        return cell
    }
}

extension AlbumViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailAlbumViewCintroller = DetailAlbumViewCintroller()
        let albums = resultsRequestAlbums[indexPath.row]
        detailAlbumViewCintroller.albums = albums
        detailAlbumViewCintroller.title = albums.artistName
        navigationController?.pushViewController(detailAlbumViewCintroller, animated: true)
    }
    
}

extension AlbumViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { [weak self] _ in
                self?.getAlbums(albumName: searchText)
                self?.albumTableView.reloadData()
            })
        }
    }
}
