//struct Movie {
//    let title: String
//    let releaseDate: String
//    let posterPath: String
//}
//
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
//
////
////  ViewController.swift
////  TMDBApp
////
////  Created by hyeonseok on 2023/08/26.
////
//
//import UIKit
//import Alamofire
//import SnapKit
//import Kingfisher
//
//
//
//
//class MovieCell: UITableViewCell {
//    static let identifier = "MovieCell"
//
//    var dateLabel = UILabel()
//    var titleLabel = UILabel()
//
//    var cardView = UIView()
//
//    var posterImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        return imageView
//    }()
//    var detailView = UIView()
//    var detailTitleLabel = UILabel()
//    var detailPersonLabel = UILabel()
//
//    var dividerView = UIView()
//    var detailLabel = UILabel()
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        contentView.addSubview(dateLabel)
//        contentView.addSubview(titleLabel)
//        contentView.addSubview(cardView)
//
//
//        dateLabel.snp.makeConstraints { make in
//            make.top.leading.equalTo(contentView).offset(20)
//        }
//
//        dateLabel.textColor = .darkGray
//        dateLabel.font = UIFont.systemFont(ofSize: 13)
//
//
//        titleLabel.snp.makeConstraints { make in
//            make.top.equalTo(dateLabel.snp.bottom).offset(10)
//            make.leading.equalTo(dateLabel)
//        }
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
//
//        let width = contentView.frame.width
//        print("width: \(width)")
//        cardView.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(10)
//            make.leading.trailing.equalTo(contentView).multipliedBy(0.9)
//            make.height.equalTo(320)
//        }
//
//        cardView.layer.cornerRadius = 10
//        cardView.backgroundColor = .systemRed.withAlphaComponent(0.3)
//        cardView.layer.shadowColor = UIColor.black.cgColor
//        cardView.layer.shadowOpacity = 0.5
//        cardView.layer.shadowRadius = 10
//        cardView.layer.shadowOffset = CGSize(width: 0, height: 0)
//
//        cardView.addSubview(posterImageView)
//        posterImageView.snp.makeConstraints { make in
//            make.leading.trailing.equalTo(contentView)
//            make.top.equalTo(titleLabel.snp.bottom).offset(10)
//            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
//        }
//
//        posterImageView.addSubview(detailView)
//        detailView.snp.makeConstraints { make in
//            make.bottom.leading.trailing.equalTo(posterImageView)
//            make.height.equalTo(110)
//        }
//
//        detailView.backgroundColor = .white
//
//        detailView.addSubview(detailTitleLabel)
//        detailTitleLabel.snp.makeConstraints { make in
//            make.top.equalTo(detailView).offset(20)
//            make.leading.trailing.equalTo(detailView).offset(20)
//        }
//        detailTitleLabel.textAlignment = .left
//        detailTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
//
//        detailView.addSubview(detailPersonLabel)
//        detailPersonLabel.snp.makeConstraints { make in
//            make.top.equalTo(detailTitleLabel.snp.bottom)
//            make.leading.trailing.equalTo(detailTitleLabel)
//        }
//
//        detailPersonLabel.textColor = .lightGray
//
//
//        detailView.addSubview(dividerView)
//        dividerView.snp.makeConstraints { make in
//            make.top.equalTo(detailPersonLabel.snp.bottom).offset(10)
//            make.width.equalTo(detailView).multipliedBy(0.9)
//            make.centerX.equalTo(detailView)
//            make.height.equalTo(1)
//        }
//
//        dividerView.backgroundColor = .black
//
//
//        detailView.addSubview(detailLabel)
//        detailLabel.snp.makeConstraints { make in
//            make.top.equalTo(dividerView.snp.bottom).offset(10)
//            make.leading.equalTo(dividerView)
//
//        }
//
//        detailLabel.text = "자세히 보기"
//        detailLabel.font = UIFont.systemFont(ofSize: 14)
//        detailLabel.textColor = .darkGray
//        detailLabel.textAlignment = .left
//
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//
//
//
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
//protocol MovieListModelDelegate: AnyObject {
//    func movieListDidChange()
//}
//
//
//class MovieListViewController: UIViewController {
//
//    private var model = MovieListModel()
//
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
//        setLayout()
//        fetchData()
//    }
//
//    func fetchData() {
//        let headers: HTTPHeaders = [ "accept": "application/json" ]
//
//        AF.request("https://api.themoviedb.org/3/movie/now_playing?api_key=\(PrivateKey.APIKey)", headers: headers).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                do {
//                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
//                    let decoder = JSONDecoder()
//                    let entityData = try decoder.decode(APIResponseModel.self, from: jsonData)
//                    let movies = entityData.results.map { movieData in
//                        return Movie(title: movieData.title,
//                                     releaseDate: movieData.releaseDate,
//                                     posterPath: movieData.posterPath)
//                    }
//                    self.model.update(with: movies)
//                    self.tableView.reloadData()
//                } catch {
//                    print(error)
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//
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
//}
//
//extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return model.movieList.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
//
//        let movie = model.movieList[indexPath.row]
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
//        print("Selected: \(model.movieList[indexPath.row])")
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 500
//    }
//}
