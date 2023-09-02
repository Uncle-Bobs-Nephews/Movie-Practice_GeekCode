//////
//////  cleanarchitecture.swift
//////  TMDBApp
//////
//////  Created by hyeonseok on 2023/09/02.
//////
////
//import Foundation
//
//struct Movie {
//    let title: String
//    let releaseDate: String
//    let posterPath: String
//}
//
//protocol MovieRepository {
//    func fetchNowPlayingMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
//}
//
////
//// Entity.swift
//// TMDBApp
////
//// Created by hyeonseok on 2023/09/02.
////
//
//import Foundation
//import Alamofire
//
//// MARK: - APIResponseModel
//struct APIResponseModel: Codable {
//    let dates: Dates
//    let page: Int
//    let results: [MovieDataModel]
//    let totalPages, totalResults: Int
//
//    enum CodingKeys: String, CodingKey {
//        case dates, page, results
//        case totalPages = "total_pages"
//        case totalResults = "total_results"
//    }
//}
//
//// MARK: - Dates
//struct Dates: Codable {
//    let maximum, minimum: String
//}
//
//// MARK: - MovieDataModel
//struct MovieDataModel: Codable {
//    let backdropPath: String
//    let id: Int
//    let originalTitle, overview: String
//    let popularity: Double
//    let posterPath, releaseDate, title: String
//    let video: Bool
//    let voteAverage: Double
//    let voteCount: Int
//
//    enum CodingKeys: String, CodingKey {
//        case backdropPath = "backdrop_path"
//        case id
//        case originalTitle = "original_title"
//        case overview, popularity
//        case posterPath = "poster_path"
//        case releaseDate = "release_date"
//        case title, video
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
//    }
//}
//
//class MovieRepositoryImpl: MovieRepository {
//
//    func fetchNowPlayingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
//        let headers: HTTPHeaders = ["accept": "application/json"]
//
//        // Replace with your actual API endpoint
//        let apiURL = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(PrivateKey.APIKey)"
//
//        AF.request(apiURL, headers: headers).responseDecodable(of: APIResponseModel.self) { response in
//            switch response.result {
//            case .success(let entityData):
//                let movies = entityData.results.map { movieData in
//                    return Movie(title: movieData.title,
//                                 releaseDate: movieData.releaseDate,
//                                 posterPath: movieData.posterPath)
//                }
//                completion(.success(movies))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//
//}
//
////
////  MovieListModel.swift
////  TMDBApp
////
////  Created by hyeonseok on 2023/09/02.
////
//
//import Foundation
//
//struct MovieListModel {
//    var movieList: [Movie]
//
//    init() {
//        movieList = []
//    }
//
//    mutating func update(with movies: [Movie]) {
//        movieList = movies
//    }
//}
//
//
////
////  UseCaseImpl.swift
////  TMDBApp
////
////  Created by hyeonseok on 2023/09/02.
////
//
//import Foundation
//
//protocol FetchNowPlayingMoviesUseCase {
//    func execute(completion: @escaping (Result<[Movie], Error>) -> Void)
//}
//
//class FetchNowPlayingMoviesUseCaseImpl: FetchNowPlayingMoviesUseCase {
//    private let movieRepository: MovieRepository
//
//    init(movieRepository: MovieRepository) {
//        self.movieRepository = movieRepository
//    }
//
//    func execute(completion: @escaping (Result<[Movie], Error>) -> Void) {
//        movieRepository.fetchNowPlayingMovies(completion: completion)
//    }
//}
//
////
////  MovieListPresenterImpl.swift
////  TMDBApp
////
////  Created by hyeonseok on 2023/09/02.
////
//protocol MovieListView: AnyObject {
//    func showMovies(_ movies: [Movie])
//    func showError(_ error: Error)
//}
//
//protocol MovieListPresenter {
//    var numberOfMovies: Int { get }
//    func movie(at index: Int) -> Movie
//    func viewDidLoad()
//    func didSelectMovie(at index: Int)
//}
//class MovieListPresenterImpl: MovieListPresenter {
//
//
//
//    var numberOfMovies: Int {
//        return movieList.count
//    }
//
//    func movie(at index: Int) -> Movie {
//        return movieList[index]
//    }
//
//
//    private let fetchNowPlayingMoviesUseCase: FetchNowPlayingMoviesUseCase
//    private weak var view: MovieListView?
//    private var movieList: [Movie] = []
//
//    init(view: MovieListView) {
//        self.view = view
//        self.fetchNowPlayingMoviesUseCase = FetchNowPlayingMoviesUseCaseImpl(movieRepository: MovieRepositoryImpl())
//    }
//
//
//
//
//    func viewDidLoad() {
//        fetchNowPlayingMoviesUseCase.execute { [weak self] result in
//            switch result {
//            case .success(let movies):
//                self?.movieList = movies
//                self?.view?.showMovies(movies)
//            case .failure(let error):
//                self?.view?.showError(error)
//            }
//        }
//    }
//
//    func didSelectMovie(at index: Int) {
//        let selectedMovie = movieList[index]
//        // 선택한 영화에 대한 동작을 수행
//        print("Selected Movie: \(selectedMovie.title)")
//    }
//
//}
////
////  MovieListViewController.swift
////  TMDBApp
////
////  Created by hyeonseok on 2023/09/02.
////
//
//import UIKit
//import SnapKit
//import Kingfisher
//
//class MovieListViewController: UIViewController, MovieListView {
//    var presenter: MovieListPresenter?
//
//    lazy var titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "영화 리스트"
//        label.font = UIFont.boldSystemFont(ofSize: 16)
//        return label
//    }()
//
//    lazy var tableView: UITableView = {
//        let tableView = UITableView(frame: view.bounds, style: .plain)
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
//
//        return tableView
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        presenter = MovieListPresenterImpl(view: self)
//
//        setLayout()
//        presenter?.viewDidLoad()
//    }
//
//    private func setLayout() {
//        view.backgroundColor = .white
//
//        view.addSubview(titleLabel)
//        titleLabel.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
//            make.centerX.equalToSuperview()
//        }
//
//        view.addSubview(tableView)
//        tableView.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(10)
//            make.leading.trailing.bottom.equalToSuperview()
//        }
//    }
//
//    func showMovies(_ movies: [Movie]) {
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
//    }
//
//    func showError(_ error: Error) {
//        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
//    }
//}
//
//extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return presenter?.numberOfMovies ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
//
//        if let movie = presenter?.movie(at: indexPath.row) {
//            cell.dateLabel.text = movie.releaseDate
//            cell.titleLabel.text = movie.title
//            cell.detailTitleLabel.text = movie.title
//            cell.detailPersonLabel.text = movie.title
//
//            if !movie.posterPath.isEmpty {
//                let posterString = "\(Configs.imagePath)w300\(movie.posterPath)"
//                let posterURL = URL(string: posterString)
//                cell.posterImageView.kf.setImage(with: posterURL, placeholder: UIImage(named: "placeholderImage"))
//            } else {
//                cell.posterImageView.image = UIImage(named: "placeholderImage")
//            }
//        } else {
//            cell.dateLabel.text = ""
//            cell.titleLabel.text = ""
//            cell.detailTitleLabel.text = ""
//            cell.detailPersonLabel.text = ""
//            cell.posterImageView.image = UIImage(named: "placeholderImage")
//        }
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter?.didSelectMovie(at: indexPath.row)
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 500
//    }
//}
//
//
///*
//class MovieListViewController: UIViewController {
//
//    var presenter: MovieListPresenter!
//
//    lazy var titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "영화 리스트"
//        label.font = UIFont.boldSystemFont(ofSize: 16)
//        return label
//    }()
//
//    lazy var tableView: UITableView = {
//        let tableView = UITableView(frame: view.bounds, style: .plain)
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
//
//        return tableView
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        presenter.viewDidLoad()
//
//    }
//
//    private func setLayout() {
//        view.backgroundColor = .white
//
//        view.addSubview(titleLabel)
//        titleLabel.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
//            make.centerX.equalToSuperview()
//        }
//
//        view.addSubview(tableView)
//        tableView.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(10)
//            make.leading.trailing.bottom.equalToSuperview()
//        }
//    }
//
//    private func fetchData() {
//        viewModel.fetchData { [weak self] in
//            DispatchQueue.main.async {
//                self?.tableView.reloadData()
//            }
//        }
//    }
//}
//
//extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.numberOfMovies()
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
//
//        let movie = viewModel.movie(at: indexPath.row)
//
//        cell.dateLabel.text = movie.releaseDate
//        cell.titleLabel.text = movie.title
//        cell.detailTitleLabel.text = movie.title
//        cell.detailPersonLabel.text = movie.title
//
//        if !movie.posterPath.isEmpty {
//            let posterString = "\(Configs.imagePath)w300\(movie.posterPath)"
//            let posterURL = URL(string: posterString)
//            print("posterString: \(posterString)")
//            cell.posterImageView.kf.setImage(with: posterURL, placeholder: UIImage(named: "placeholderImage"))
//        } else {
//            cell.posterImageView.image = UIImage(named: "placeholderImage")
//        }
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        print("Selected: \(viewModel.movie(at: indexPath.row))")
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 500
//    }
//}
// */
