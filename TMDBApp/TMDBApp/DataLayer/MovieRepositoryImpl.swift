//
//  MovieRepositoryImpl.swift
//  TMDBApp
//
//  Created by hyeonseok on 2023/09/02.
//

import Foundation
import Alamofire

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
