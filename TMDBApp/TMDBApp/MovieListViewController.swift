//
//  ViewController.swift
//  TMDBApp
//
//  Created by hyeonseok on 2023/08/26.
//

import UIKit
import Alamofire
import SnapKit

class MovieCell: UITableViewCell {
    
    static let identifier = "MovieCell"
    
    var titleLabel = UILabel()
    var posterImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MovieListViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "영화 리스트"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)

        return tableView
    }()

    let data = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }

    }
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        
        cell.backgroundColor = .systemTeal.withAlphaComponent(0.3)
        
        cell.titleLabel.text = data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Selected: \(data[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}


