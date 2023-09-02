////
////  MovieListViewController.swift
////  TMDBApp
////
////  Created by hyeonseok on 2023/09/02.
////
//
import UIKit
import SnapKit
import Kingfisher

class MovieListViewController: UIViewController, MovieListView {
    var presenter: MovieListPresenter?

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
        presenter = MovieListPresenterImpl(view: self)

        setLayout()
        presenter?.viewDidLoad()
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

    func showMovies(_ movies: [Movie]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return presenter?.numberOfMovies ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell

        if let movie = presenter?.movie(at: indexPath.row) {
            cell.dateLabel.text = movie.releaseDate
            cell.titleLabel.text = movie.title
            cell.detailTitleLabel.text = movie.title
            cell.detailPersonLabel.text = movie.title

            if !movie.posterPath.isEmpty {
                let posterString = "\(Configs.imagePath)w300\(movie.posterPath)"
                let posterURL = URL(string: posterString)
                cell.posterImageView.kf.setImage(with: posterURL, placeholder: UIImage(named: "placeholderImage"))
            } else {
                cell.posterImageView.image = UIImage(named: "placeholderImage")
            }
        } else {
            cell.dateLabel.text = ""
            cell.titleLabel.text = ""
            cell.detailTitleLabel.text = ""
            cell.detailPersonLabel.text = ""
            cell.posterImageView.image = UIImage(named: "placeholderImage")
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectMovie(at: indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
}
