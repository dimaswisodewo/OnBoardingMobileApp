//
//  OnboardingCollectionViewCell.swift
//  OnBoardingMobileApp
//
//  Created by Dimas Wisodewo on 24/07/23.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "OnboardingCollectionViewCell"
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Onboarding BG")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Work In Beanbag")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let secondaryContentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Work In Beanbag")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Poppins-Bold", size: 28)
        label.textColor = UIColor(named: "Heading")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subheaderLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.textColor = UIColor(named: "Subheading")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        
        contentView.addSubview(backgroundImage)
        contentView.addSubview(contentImageView)
        contentView.addSubview(secondaryContentImageView)
        contentView.addSubview(headerLabel)
        contentView.addSubview(subheaderLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        let safeArea = contentView.safeAreaInsets
        
        // Image background
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: safeArea.top + 42),
            backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImage.heightAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
        
        // Content image
        NSLayoutConstraint.activate([
            contentImageView.widthAnchor.constraint(equalTo: backgroundImage.widthAnchor, multiplier: 0.8),
            contentImageView.heightAnchor.constraint(equalTo: backgroundImage.heightAnchor, multiplier: 0.8),
            contentImageView.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: 60),
            contentImageView.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor)
        ])
        
        // Secondary content image
        NSLayoutConstraint.activate([
            secondaryContentImageView.widthAnchor.constraint(equalTo: backgroundImage.widthAnchor, multiplier: 0.42),
            secondaryContentImageView.heightAnchor.constraint(equalTo: backgroundImage.heightAnchor, multiplier: 0.42),
            secondaryContentImageView.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: -70),
            secondaryContentImageView.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 40)
        ])
        
        // Header label
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: 60),
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 41),
            headerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -41)
        ])
        
        // Subheader label
        NSLayoutConstraint.activate([
            subheaderLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 12),
            subheaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 41),
            subheaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -41)
        ])
    }
    
    func configureImage(image: UIImage) {
        contentImageView.image = image
    }
    
    func configureSecondaryImage(image: UIImage?) {
        secondaryContentImageView.image = image
    }
    
    func configureHeaderLabel(with headerText: String) {
        headerLabel.text = headerText
    }
    
    func configureSubheaderLabel(with subheaderText: String) {
        subheaderLabel.text = subheaderText
    }
}
