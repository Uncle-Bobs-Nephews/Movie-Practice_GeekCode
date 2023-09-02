//
//  MovieCell.swift
//  TMDBApp
//
//  Created by hyeonseok on 2023/09/02.
//

import UIKit
import SnapKit

class MovieCell: UITableViewCell {
    static let identifier = "MovieCell"
    
    var dateLabel = UILabel()
    var titleLabel = UILabel()

    var cardView = UIView()
    
    var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    var detailView = UIView()
    var detailTitleLabel = UILabel()
    var detailPersonLabel = UILabel()
    
    var dividerView = UIView()
    var detailLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(dateLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(cardView)

        
        dateLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).offset(20)
        }
        
        dateLabel.textColor = .darkGray
        dateLabel.font = UIFont.systemFont(ofSize: 13)

        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.leading.equalTo(dateLabel)
        }
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)

        let width = contentView.frame.width
        print("width: \(width)")
        cardView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(contentView).multipliedBy(0.9)
            make.height.equalTo(320)
        }
        
        cardView.layer.cornerRadius = 10
        cardView.backgroundColor = .systemRed.withAlphaComponent(0.3)
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.shadowRadius = 10
        cardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        cardView.addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
        
        posterImageView.addSubview(detailView)
        detailView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(posterImageView)
            make.height.equalTo(110)
        }
        
        detailView.backgroundColor = .white
        
        detailView.addSubview(detailTitleLabel)
        detailTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(detailView).offset(20)
            make.leading.trailing.equalTo(detailView).offset(20)
        }
        detailTitleLabel.textAlignment = .left
        detailTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)

        detailView.addSubview(detailPersonLabel)
        detailPersonLabel.snp.makeConstraints { make in
            make.top.equalTo(detailTitleLabel.snp.bottom)
            make.leading.trailing.equalTo(detailTitleLabel)
        }
        
        detailPersonLabel.textColor = .lightGray

        
        detailView.addSubview(dividerView)
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(detailPersonLabel.snp.bottom).offset(10)
            make.width.equalTo(detailView).multipliedBy(0.9)
            make.centerX.equalTo(detailView)
            make.height.equalTo(1)
        }
        
        dividerView.backgroundColor = .black
        
        
        detailView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(10)
            make.leading.equalTo(dividerView)
            
        }
        
        detailLabel.text = "자세히 보기"
        detailLabel.font = UIFont.systemFont(ofSize: 14)
        detailLabel.textColor = .darkGray
        detailLabel.textAlignment = .left

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
