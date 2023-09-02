//
//  ViewController.swift
//  TMDBApp
//
//  Created by hyeonseok on 2023/08/26.
//

import UIKit
import SnapKit
import Kingfisher


class MovieListViewController: UIViewController {
    
    // MARK: - View Model
    private var viewModel = MovieListViewModel()

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

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        fetchData()
    }
    
    private func setLayout() {
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

    private func fetchData() {
        viewModel.fetchData { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMovies()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        
        let movie = viewModel.movie(at: indexPath.row)

        cell.dateLabel.text = movie.releaseDate
        cell.titleLabel.text = movie.title
        cell.detailTitleLabel.text = movie.title
        cell.detailPersonLabel.text = movie.title

        if !movie.posterPath.isEmpty {
            let posterString = "\(Configs.imagePath)w300\(movie.posterPath)"
            let posterURL = URL(string: posterString)
            print("posterString: \(posterString)")
            cell.posterImageView.kf.setImage(with: posterURL, placeholder: UIImage(named: "placeholderImage"))
        } else {
            cell.posterImageView.image = UIImage(named: "placeholderImage")
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Selected: \(viewModel.movie(at: indexPath.row))")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
}
