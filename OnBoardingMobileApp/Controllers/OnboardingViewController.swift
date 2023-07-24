//
//  OnboardingViewController.swift
//  OnBoardingMobileApp
//
//  Created by Dimas Wisodewo on 24/07/23.
//

import UIKit

class OnboardingViewController: UIViewController {

    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Onboarding BG")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
    
    private let skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(UIColor(named: "Subheading"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "PrimaryBlack")
        button.setTitle("Next  ", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var linesView = [UIView]()
    
    private var selectedViewIndex = 0
    
    private let onboardingTexts = [
        ("Let's Get Started", "Our goal is to ensure that you have everything you need to feel comfortable, confident, and ready to make an impact."),
        ("Your Onboarding Journey Begins!", "Our goal is to ensure that you have everything you need to feel comfortable, confident, and ready to make an impact."),
        ("Your First Steps to Success", "Our goal is to ensure that you have everything you need to feel comfortable, confident, and ready to make an impact.")
    ]
    
    private lazy var onboardingImagesName = [
        "Work In Beanbag",
        "Work In Desk",
        "Thumb Up"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(backgroundImage)
        view.addSubview(contentImageView)
        view.addSubview(headerLabel)
        view.addSubview(subheaderLabel)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        
        setupLineViews()
        setupOnboardingText()
        setupOnboardingImage()
        setupButtonAction()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupConstraints()
    }

    private func setupConstraints() {
        
        let safeArea = view.safeAreaInsets
        
        // Image background
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor, constant: safeArea.top + 10),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.heightAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        // Content image
        NSLayoutConstraint.activate([
            contentImageView.widthAnchor.constraint(equalTo: backgroundImage.widthAnchor, multiplier: 0.8),
            contentImageView.heightAnchor.constraint(equalTo: backgroundImage.heightAnchor, multiplier: 0.8),
            contentImageView.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: 60),
            contentImageView.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: 45)
        ])
        
        // Header label
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: 60),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 41),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -41)
        ])
        
        // Subheader label
        NSLayoutConstraint.activate([
            subheaderLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 12),
            subheaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 41),
            subheaderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -41)
        ])
        
        // Lines view
        for lineIndex in 0..<linesView.count {
            
            // Line height
            NSLayoutConstraint.activate([
                linesView[lineIndex].widthAnchor.constraint(equalToConstant: 50),
                linesView[lineIndex].heightAnchor.constraint(equalToConstant: 6)
            ])
            
            // First item
            if lineIndex == 0 {
                NSLayoutConstraint.activate([
                    linesView[lineIndex].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 41),
                    linesView[lineIndex].bottomAnchor.constraint(equalTo: skipButton.topAnchor, constant: -48)
                ])
                continue
            }
            // Rest of the items
            NSLayoutConstraint.activate([
                linesView[lineIndex].leadingAnchor.constraint(equalTo: linesView[lineIndex - 1].trailingAnchor, constant: 8),
                linesView[lineIndex].centerYAnchor.constraint(equalTo: linesView[lineIndex - 1].centerYAnchor)
            ])
        }
        
        // Skip button
        NSLayoutConstraint.activate([
            skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12 - safeArea.bottom),
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 41)
        ])
        
        // Next button
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12 - safeArea.bottom),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -41),
            nextButton.widthAnchor.constraint(equalToConstant: 100),
            nextButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupButtonAction() {
        // Skip button
        skipButton.addTarget(self, action: #selector(previousButtonPressed), for: .touchUpInside)
        
        // Next button
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
    }
    
    private func setupOnboardingText() {
        headerLabel.text = onboardingTexts[selectedViewIndex].0
        subheaderLabel.text = onboardingTexts[selectedViewIndex].1
    }
    
    private func setupOnboardingImage() {
        if let onboardingImage = UIImage(named: onboardingImagesName[selectedViewIndex]) {
            contentImageView.image = onboardingImage
        }
    }
    
    private func setupLineViews() {
        for lineIndex in 0..<3 {
            let lineView = UIView()
            let colorName = lineIndex == 0 ? "PrimaryBlack" : "PrimaryGrey"
            lineView.backgroundColor = UIColor(named: colorName)
            lineView.layer.cornerRadius = 3
            lineView.translatesAutoresizingMaskIntoConstraints = false
            linesView.append(lineView)
            view.addSubview(lineView)
        }
    }
    
    private func setSelectedLine(index: Int) {
        for lineIndex in 0..<linesView.count {
            let lineColorName = lineIndex == selectedViewIndex ? "PrimaryBlack" : "PrimaryGrey"
            
            linesView[lineIndex].backgroundColor = UIColor(named: lineColorName)
        }
    }
    
    @objc private func nextButtonPressed() {
        selectedViewIndex += 1
        
        if selectedViewIndex >= linesView.count {
            selectedViewIndex -= 1
        }
        
        setSelectedLine(index: selectedViewIndex)
        
        setupOnboardingText()
        setupOnboardingImage()
    }
    
    @objc private func previousButtonPressed() {
        selectedViewIndex -= 1
        
        if selectedViewIndex < 0 {
            selectedViewIndex += 1
        }
        
        setSelectedLine(index: selectedViewIndex)
        
        setupOnboardingText()
        setupOnboardingImage()
    }
}
