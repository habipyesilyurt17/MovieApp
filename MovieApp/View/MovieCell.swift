//
//  MovieCell.swift
//  MovieApp
//
//  Created by habip on 28.08.2022.
//

import UIKit
import AlamofireImage

class MovieCell: UITableViewCell {
    
    private let movieImageView: UIImageView = UIImageView()
    private let movieTitleLabel: UILabel = UILabel()
    
    private let randomImage: String = "https://picsum.photos/200/300"
    private let imageUrl: String = "https://image.tmdb.org/t/p/w500"
    
    enum Identifier: String {
        case custom = "MovieCell"
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(movieImageView)
        addSubview(movieTitleLabel)
        
        configureMovieImageView()
        configureMovieTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(movie: Movie) {
        movieTitleLabel.text = movie.originalTitle
        movieImageView.af.setImage(withURL: URL(string: imageUrl + movie.posterPath) ?? URL(string: randomImage)!)
    }
    
    private func configureMovieImageView() {
        movieImageView.layer.cornerRadius = 10
        movieImageView.clipsToBounds = true
        setMovieImageViewConstraints()
    }
    
    private func setMovieImageViewConstraints() {
        movieImageView.translatesAutoresizingMaskIntoConstraints                                                     = false
        movieImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                   = true
        movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive                   = true
        movieImageView.heightAnchor.constraint(equalToConstant: 250).isActive                                       = true
        movieImageView.widthAnchor.constraint(equalTo: movieImageView.heightAnchor, multiplier: 3/4).isActive = true
    }
    
    private func configureMovieTitleLabel() {
        movieTitleLabel.numberOfLines = 0
        movieTitleLabel.adjustsFontSizeToFitWidth = true
        movieTitleLabel.font = .boldSystemFont(ofSize: 20)
        setMovieTitleLabelConstraints()
    }
    
    private func setMovieTitleLabelConstraints() {
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints                                                      = false
        movieTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                    = true
        movieTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 12).isActive = true
        movieTitleLabel.heightAnchor.constraint(equalToConstant: 80).isActive                                         = true
        movieTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive                 = true
    }
    
}
