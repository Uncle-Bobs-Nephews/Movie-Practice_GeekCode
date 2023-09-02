//
//  MovieListPresenterImpl.swift
//  TMDBApp
//
//  Created by hyeonseok on 2023/09/02.
//

import Foundation

protocol MovieListView: AnyObject {
    func showMovies(_ movies: [Movie])
    func showError(_ error: Error)
}

protocol MovieListPresenter {
    var numberOfMovies: Int { get }
    func movie(at index: Int) -> Movie
    func viewDidLoad()
    func didSelectMovie(at index: Int)
}
class MovieListPresenterImpl: MovieListPresenter {


    
    var numberOfMovies: Int {
        return movieList.count
    }

    func movie(at index: Int) -> Movie {
        return movieList[index]
    }

    
    private let fetchNowPlayingMoviesUseCase: FetchNowPlayingMoviesUseCase
    private weak var view: MovieListView?
    private var movieList: [Movie] = []

    init(view: MovieListView) {
        self.view = view
        self.fetchNowPlayingMoviesUseCase = FetchNowPlayingMoviesUseCaseImpl(movieRepository: MovieRepositoryImpl())
    }

    
    

    func viewDidLoad() {
        fetchNowPlayingMoviesUseCase.execute { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movieList = movies
                self?.view?.showMovies(movies)
            case .failure(let error):
                self?.view?.showError(error)
            }
        }
    }

    func didSelectMovie(at index: Int) {
        let selectedMovie = movieList[index]
        // 선택한 영화에 대한 동작을 수행
        print("Selected Movie: \(selectedMovie.title)")
    }

}
