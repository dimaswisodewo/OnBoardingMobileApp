//
//  OnboardingPageViewController.swift
//  OnBoardingMobileApp
//
//  Created by Dimas Wisodewo on 24/07/23.
//

import UIKit

class OnboardingPageViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var subheaderLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var skipButton: UIButton! {
        didSet {
            skipButton.addTarget(
                self,
                action: #selector(previousButtonPressed),
                for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = 10
            nextButton.semanticContentAttribute = .forceRightToLeft
            nextButton.addTarget(
                self,
                action: #selector(nextButtonPressed),
                for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var lineStackView: UIStackView!
    
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

        setupLine()
        setOnboardingText()
    }
    
    // Make lines rounded
    private func setupLine() {
        lineStackView.subviews.forEach { line in
            line.layer.cornerRadius = 3
        }
    }
    
    private func setSelectedLine(index: Int) {
        for lineIndex in 0..<lineStackView.subviews.count {
            let lineColorName = lineIndex == selectedViewIndex ? "PrimaryBlack" : "PrimaryGrey"
            
            lineStackView.subviews[lineIndex].backgroundColor = UIColor(named: lineColorName)
        }
    }
    
    private func setOnboardingText() {
        headerLabel.text = onboardingTexts[selectedViewIndex].0
        subheaderLabel.text = onboardingTexts[selectedViewIndex].1
    }
    
    private func setOnboardingImage() {
        if let onboardingImage = UIImage(named: onboardingImagesName[selectedViewIndex]) {
            imageView.image = onboardingImage
        }
    }
    
    @objc private func nextButtonPressed() {
        selectedViewIndex += 1
        
        if selectedViewIndex >= lineStackView.subviews.count {
            selectedViewIndex -= 1
        }
        
        setSelectedLine(index: selectedViewIndex)
        
        setOnboardingText()
        setOnboardingImage()
    }
    
    @objc private func previousButtonPressed() {
        selectedViewIndex -= 1
        
        if selectedViewIndex < 0 {
            selectedViewIndex += 1
        }
        
        setSelectedLine(index: selectedViewIndex)
        
        setOnboardingText()
        setOnboardingImage()
    }

    private func setupViewControllers() {
        
    }
}
