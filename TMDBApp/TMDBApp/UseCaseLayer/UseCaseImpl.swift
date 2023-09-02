//
//  UseCaseImpl.swift
//  TMDBApp
//
//  Created by hyeonseok on 2023/09/02.
//

import Foundation

protocol FetchNowPlayingMoviesUseCase {
    func execute(completion: @escaping (Result<[Movie], Error>) -> Void)
}

class FetchNowPlayingMoviesUseCaseImpl: FetchNowPlayingMoviesUseCase {
    private let movieRepository: MovieRepository

    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }

    func execute(completion: @escaping (Result<[Movie], Error>) -> Void) {
        movieRepository.fetchNowPlayingMovies(completion: completion)
    }
}
