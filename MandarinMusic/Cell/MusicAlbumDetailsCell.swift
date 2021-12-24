//
//  MusicAlbumDetailsCell.swift
//  MandarinMusic
//
//  Created by Александр Александров on 20.12.2021.
//

import Foundation
import UIKit

class MusicAlbumDetailsCell: UITableViewCell {

    let nameSongLabel: UILabel = {
       let label = UILabel()
        label.text = "Song"
        return label
    }()
    
    let separatorStyleView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
       
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configurationCell()
        configurationConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurationCell() {
        addSabviews(views: [nameSongLabel, separatorStyleView])
    }
   
    private func configurationConstraints() {

        nameSongLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
        }

        separatorStyleView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.bottom.leading.trailing.equalToSuperview()

        }
    }
    
    public func configurationContent(_ songs: ResultsSongs) {
        self.nameSongLabel.text = songs.trackName
    }
}
