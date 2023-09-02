//
// Entity.swift
// TMDBApp
//
// Created by hyeonseok on 2023/09/02.
//

import Foundation
import Alamofire

// MARK: - APIResponseModel
struct APIResponseModel: Codable {
    let dates: Dates
    let page: Int
    let results: [MovieDataModel]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String
}

// MARK: - MovieDataModel
struct MovieDataModel: Codable {
    let backdropPath: String
    let id: Int
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

class MovieRepositoryImpl: MovieRepository {
    
    func fetchNowPlayingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let headers: HTTPHeaders = ["accept": "application/json"]

        // Replace with your actual API endpoint
        let apiURL = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(PrivateKey.APIKey)"

        AF.request(apiURL, headers: headers).responseDecodable(of: APIResponseModel.self) { response in
            switch response.result {
            case .success(let entityData):
                let movies = entityData.results.map { movieData in
                    return Movie(title: movieData.title,
                                 releaseDate: movieData.releaseDate,
                                 posterPath: movieData.posterPath)
                }
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
