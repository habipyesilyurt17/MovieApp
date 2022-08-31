//
//  MovieViewController.swift
//  MovieApp
//
//  Created by habip on 28.08.2022.
//

import UIKit

final class MovieViewController: UIViewController {
    private let searchBar: UISearchBar = UISearchBar()
    private let labelTitle: UILabel = UILabel()
    private let tableView: UITableView = UITableView()
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    private lazy var movies: [Movie] = []
    private lazy var filteredMovies: [Movie] = []
    private var selectedMovie: Movie?
    
    lazy var viewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureSearchBar()
        configureIndicator()
        configureTableView()
        
        viewModel.getMovies(pagination: false) { errorMessage in
            if let errorMessage = errorMessage {
                print("error: \(errorMessage)")
            }
        }
        viewModel.setDelegate(movie: self)
        navigationItem.title = "Movie List"
    }
    
}

//MARK: - Configuration UI
extension MovieViewController {
    private func configureSearchBar() {
        view.addSubview(searchBar)
        searchBar.placeholder = "Search a Movie"
        setSearchBarDelegate()
        setSearchBarConstraints()
    }
    
    private func setSearchBarDelegate() {
        searchBar.delegate = self
    }
    
    private func setSearchBarConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func configureIndicator() {
        tableView.addSubview(indicator)
        indicator.color = .red
        indicator.startAnimating()
        setIndicatorConstraints()
    }

    private func setIndicatorConstraints() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor, constant: 0).isActive = true
        indicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor, constant: 0).isActive = true
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegate()
        tableView.rowHeight = 300
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.Identifier.custom.rawValue)
        setTableViewConstraints()
    }
    
    private func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive      = true
    }
    
    private func setTableViewDelegate() {
        tableView.delegate   = self
        tableView.dataSource = self
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let indicator = UIActivityIndicatorView()
        indicator.center = footerView.center
        indicator.color = .red
        footerView.addSubview(indicator)
        indicator.startAnimating()
        return footerView
    }
}

extension MovieViewController: MovieProtocol {    
    func showIndicator(isShow: Bool) {
        isShow ? indicator.startAnimating() : indicator.stopAnimating()
    }

    func saveDatas(pagination: Bool, movies: [Movie]) {
        if pagination {
            self.movies.append(contentsOf: movies)
        } else {
            self.movies =  movies
        }
        filteredMovies = self.movies
        tableView.reloadData()
    }
}


extension MovieViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.Identifier.custom.rawValue) as! MovieCell
        let movie = filteredMovies[indexPath.row]
        cell.set(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMovie = filteredMovies[indexPath.row]
        let movieDetailVC =  MovieDetailViewController()
        movieDetailVC.choosenMovie = selectedMovie
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            self.tableView.tableFooterView = createSpinnerFooter()
            
            viewModel.getMovies(pagination: true) { errorMessage in
                DispatchQueue.main.async {
                    self.tableView.tableFooterView = nil
                }
               
                if let errorMessage = errorMessage {
                    print("error: \(errorMessage)")
                }
            }
        }
    }
}


extension MovieViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredMovies = []
        if searchText == "" {
            filteredMovies = movies
        } else {
            for movie in movies {
                if movie.title.lowercased().contains(searchText.lowercased()) {
                    filteredMovies.append(movie)
                }
            }
        }
        self.tableView.reloadData()
    }
}
