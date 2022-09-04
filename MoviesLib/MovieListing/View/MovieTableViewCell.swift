//
//  MovieTableViewCell.swift
//  MoviesLib
//
//  Created by Fernando Cesar Martins on 02/09/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    
    @IBOutlet weak var labelSummary: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelRating: UILabel!
    
    
    func configure(with movie: Movie){
        labelTitle.text = movie.title
        labelRating.text = movie.ratingFormatted
        labelSummary.text = movie.summary
        imageViewPoster.image = UIImage(named: movie.imageSmall)
        imageViewPoster.layer.cornerRadius = 8
    }
    
    
    
}
