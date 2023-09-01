//
//  MovieListPresenterImpl.swift
//  TMDBApp
//
//  Created by hyeonseok on 2023/09/02.
//

import UIKit
import Alamofire

protocol MovieListPresenter {
    func fetchData()
}

class MovieListPresenterImpl: MovieListPresenter {
    private weak var view: MovieListView?
    private var model: MovieListModel

    init(view: MovieListView) {
        self.view = view
        self.model = MovieListModel()
    }

    func fetchData() {
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
                    self.model.update(with: movies)
                    self.view?.updateMovieList(with: movies)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
