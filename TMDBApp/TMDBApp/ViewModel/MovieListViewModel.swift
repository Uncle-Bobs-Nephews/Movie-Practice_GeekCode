//
//  MovieListPresenterImpl.swift
//  TMDBApp
//
//  Created by hyeonseok on 2023/09/02.
//

import UIKit
import Alamofire

class MovieListViewModel {
    var movieList: [Movie] = []
    
    func fetchData(completion: @escaping () -> Void) {
        let headers: HTTPHeaders = [ "accept": "application/json" ]
        
        AF.request("https://api.themoviedb.org/3/movie/now_playing?api_key=\(PrivateKey.APIKey)", headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                    let decoder = JSONDecoder()
                    let entityData = try decoder.decode(APIResponseModel.self, from: jsonData)
                    let movies = entityData.results.map { movieData in
                        return Movie(title: movieData.title,
                                     releaseDate: movieData.releaseDate,
                                     posterPath: movieData.posterPath)
                    }
                    self.movieList = movies
                    completion()
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfMovies() -> Int {
        return movieList.count
    }
    
    func movie(at index: Int) -> Movie {
        return movieList[index]
    }

}
