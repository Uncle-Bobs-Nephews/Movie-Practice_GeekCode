//
//  MovieModel.swift
//  TMDBApp
//
//  Created by hyeonseok on 2023/09/02.
//

import Foundation

struct Movie {
    let title: String
    let releaseDate: String
    let posterPath: String
}

protocol MovieRepository {
    func fetchNowPlayingMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
}
