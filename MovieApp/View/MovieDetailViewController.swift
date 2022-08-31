//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by habip on 28.08.2022.
//

import UIKit
import AlamofireImage


class MovieDetailViewController: UIViewController {
    
    var choosenMovie: Movie?
    
    private let topImageContainerView: UIView = UIView()
    private let movieImage: UIImageView = UIImageView()
    private let movieTitle: UILabel = UILabel()
    private let dateLabel: UILabel = UILabel()
    private let releaseDate: UILabel = UILabel()
    private let voteAverage: UILabel = UILabel()
    private let voteLabel: UILabel = UILabel()
    private let overview: UITextView = UITextView()
    private let hStackView: UIStackView = UIStackView()
    private let vStackDate: UIStackView = UIStackView()
    private let dateUIView: UIView = UIView()
    private let vStackVote: UIStackView = UIStackView()
    private let voteUIView: UIView = UIView()
    
    private let randomImage: String = "https://picsum.photos/200/300"
    private let imageUrl: String     = "https://image.tmdb.org/t/p/w500"
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        super.viewDidLoad()
        configureTopImageContainerView()
        configureMovieImage()
        configureMovietitle()
        configureDateLabel()
        configureReleaseDate()
        configureVoteAverage()
        configureVoteLabel()
        configureDateUIView()
        configureVoteUIView()
        configureHStackView()
        configureVStackDate()
        configureVStackVote()
        configureOverview()
    }
}

//MARK: - Configuration UI
extension MovieDetailViewController {
    private func configureTopImageContainerView() {
        view.addSubview(topImageContainerView)
        topImageContainerView.backgroundColor = .white
        setTopImageContainerViewConstraints()
    }
    
    private func setTopImageContainerViewConstraints() {
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
    }
    
    private func configureMovieImage() {
        topImageContainerView.addSubview(movieImage)
        movieImage.af.setImage(withURL: URL(string: imageUrl + (choosenMovie?.backdropPath ?? randomImage)) ?? URL(string: randomImage)!)
        movieImage.layer.cornerRadius = 10
        movieImage.clipsToBounds = true
        movieImage.contentMode = .scaleAspectFit
        setMovieImageViewConstraints()
    }
    
    private func setMovieImageViewConstraints() {
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieImage.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        movieImage.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        movieImage.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 1.0).isActive = true
        movieImage.widthAnchor.constraint(equalTo: topImageContainerView.widthAnchor, multiplier: 0.9).isActive = true
        
    }
    
    private func configureMovietitle() {
        view.addSubview(movieTitle)
        movieTitle.text = choosenMovie?.title
        movieTitle.font = .boldSystemFont(ofSize: 18)
        setMovietitleConstraints()
    }
    
    private func setMovietitleConstraints() {
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        movieTitle.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor, constant: 25).isActive = true
        movieTitle.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        movieTitle.heightAnchor.constraint(greaterThanOrEqualToConstant: 10).isActive = true
    }
    
    private func configureDateLabel() {
        view.addSubview(dateLabel)
        dateLabel.text = "Release Date"
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.alpha = 0.5
    }
    
    private func configureReleaseDate() {
        view.addSubview(releaseDate)
        releaseDate.text = choosenMovie?.releaseDate
    }
    
    private func configureVoteLabel() {
        view.addSubview(voteLabel)
        voteLabel.text = "Vote"
        voteLabel.font = .systemFont(ofSize: 14)
        voteLabel.alpha = 0.5
    }
    
    private func configureVoteAverage() {
        view.addSubview(voteAverage)
        voteAverage.text = String(choosenMovie?.voteAverage ?? 0)
    }
    
    private func configureDateUIView() {
        dateUIView.backgroundColor = .white
        dateUIView.addSubview(vStackDate)
    }
    
    private func configureVoteUIView() {
        voteUIView.backgroundColor = .white
        voteUIView.addSubview(vStackVote)
    }
    
    private func configureVStackDate() {
        view.addSubview(vStackDate)
        vStackDate.axis = .vertical
        vStackDate.alignment = .leading
        vStackDate.distribution = .fillEqually
        vStackDate.addArrangedSubview(self.dateLabel)
        vStackDate.addArrangedSubview(self.releaseDate)
        setVStackDateConstraints()
    }
    
    private func setVStackDateConstraints() {
        vStackDate.translatesAutoresizingMaskIntoConstraints = false
        vStackDate.topAnchor.constraint(equalTo: dateUIView.topAnchor).isActive = true
        vStackDate.leadingAnchor.constraint(equalTo: dateUIView.leadingAnchor).isActive = true
        vStackDate.trailingAnchor.constraint(equalTo: dateUIView.trailingAnchor).isActive = true
        vStackDate.bottomAnchor.constraint(equalTo: dateUIView.bottomAnchor).isActive = true
        
    }
    
    private func configureVStackVote() {
        view.addSubview(vStackVote)
        vStackVote.axis = .vertical
        vStackVote.alignment = .trailing
        vStackVote.distribution = .fillEqually
        vStackVote.addArrangedSubview(self.voteLabel)
        vStackVote.addArrangedSubview(self.voteAverage)
        setVStackVoteConstraints()
    }
    
    private func setVStackVoteConstraints() {
        vStackVote.translatesAutoresizingMaskIntoConstraints = false
        vStackVote.topAnchor.constraint(equalTo: voteUIView.topAnchor).isActive = true
        vStackVote.leadingAnchor.constraint(equalTo: voteUIView.leadingAnchor).isActive = true
        vStackVote.trailingAnchor.constraint(equalTo: voteUIView.trailingAnchor).isActive = true
        vStackVote.bottomAnchor.constraint(equalTo: voteUIView.bottomAnchor).isActive = true
    }
    
    private func configureHStackView() {
        view.addSubview(hStackView)
        hStackView.axis = .horizontal
        hStackView.alignment = .fill
        hStackView.distribution = .fill
        hStackView.addArrangedSubview(self.dateUIView)
        hStackView.addArrangedSubview(self.voteUIView)
        setHStackViewConstraints()
    }
    
    private func setHStackViewConstraints() {
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 10).isActive = true
        hStackView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        hStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        hStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
    }
    
    private func configureOverview() {
        view.addSubview(overview)
        overview.text = choosenMovie?.overview
        overview.sizeToFit()
        overview.isScrollEnabled = false
        overview.isEditable = false
        overview.isScrollEnabled = false
        overview.font = .systemFont(ofSize: 16)
        setOverviewConstraints()
    }
    
    private func setOverviewConstraints() {
        overview.translatesAutoresizingMaskIntoConstraints = false
        overview.topAnchor.constraint(equalTo: releaseDate.bottomAnchor, constant: 20).isActive = true
        overview.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        overview.leadingAnchor.constraint(equalTo: hStackView.leadingAnchor).isActive = true
        overview.trailingAnchor.constraint(equalTo: hStackView.trailingAnchor).isActive = true
        
    }
}
