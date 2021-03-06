//
//  AlbunViewCell.swift
//  MandarinMusic
//
//  Created by Александр Александров on 20.12.2021.
//

import Foundation
import UIKit

class AlbunViewCell: UITableViewCell {
    
    let separatorStyleView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    var albumImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemBlue
        return image
    }()
    
    let albumNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let artistNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var numberOfTracksLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configuretionCell()
        configurationConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Добавь элементы в ячейку
    private func configuretionCell() {
        addSabviews(views: [albumImage, albumNameLabel, artistNameLabel, numberOfTracksLabel, separatorStyleView])
    }
    
    /// Установи ограничения
    private func configurationConstraints() {
        
        let imageSize: CGFloat = 60
        
        albumImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.bottom.equalToSuperview().inset(5)
            make.size.equalTo(imageSize)
        }
        // Закругли Image
        albumImage.layer.cornerRadius = imageSize / 2
        
        albumNameLabel.snp.makeConstraints { make in
            make.top.equalTo(albumImage.snp.top).inset(10)
            make.leading.equalTo(albumImage.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(30)
        }
        
        artistNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(albumImage.snp.bottom).offset(-10)
            make.leading.equalTo(albumImage.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(30)
        }
        
        numberOfTracksLabel.snp.makeConstraints { make in
            make.bottom.equalTo(albumImage.snp.bottom).offset(-10)
            make.trailing.equalToSuperview().inset(10)
        }
        
        separatorStyleView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.equalTo(artistNameLabel.snp.leading)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
    }
    
    public func configurationContent(_ albumResult: ResultsAlbums) {
        let url = URL(string: albumResult.artworkUrl60!)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.albumImage.image = UIImage(data: data!)
            }
        }
        
        self.albumNameLabel.text = albumResult.collectionName
        self.artistNameLabel.text = albumResult.artistName
        self.numberOfTracksLabel.text = "\(albumResult.trackCount!) tracks"
    }
}
