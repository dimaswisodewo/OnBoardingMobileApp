//
//  OnboardingViewController.swift
//  OnBoardingMobileApp
//
//  Created by Dimas Wisodewo on 24/07/23.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.bounces = false
        
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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
    
    /// Contains `Tuple(String, String)`
    /// 1 - Header text
    /// 2 - Subheader text
    private let onboardingTexts = [
        ("Let's Get Started", "Our goal is to ensure that you have everything you need to feel comfortable, confident, and ready to make an impact."),
        ("Your Onboarding Journey Begins!", "Our goal is to ensure that you have everything you need to feel comfortable, confident, and ready to make an impact."),
        ("Your First Steps to Success", "Our goal is to ensure that you have everything you need to feel comfortable, confident, and ready to make an impact.")
    ]
    
    private let onboardingImagesName = [
        "Work In Beanbag",
        "Work In Desk",
        "Thumb Up"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        
        setupLineViews()
        setupButtonAction()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupConstraints()
    }

    private func setupConstraints() {
        
        let safeArea = view.safeAreaInsets
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: linesView[0].topAnchor, constant: -60)
        ])
        
        // Lines view
        for lineIndex in 0..<linesView.count {
            // Line height
            NSLayoutConstraint.activate([
                linesView[lineIndex].widthAnchor.constraint(equalToConstant: 50),
                linesView[lineIndex].heightAnchor.constraint(equalToConstant: 6)
            ])
            // First line
            if lineIndex == 0 {
                NSLayoutConstraint.activate([
                    linesView[lineIndex].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 41),
                    linesView[lineIndex].bottomAnchor.constraint(equalTo: skipButton.topAnchor, constant: -48)
                ])
                continue
            }
            // Rest of the lines
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
        var selectedIndex = selectedViewIndex + 1
        
        if selectedIndex >= linesView.count {
            selectedIndex -= 1
        }
        
        // Prevent selecting the same item multiple times, causing jittery when spamming next button
        if selectedIndex == selectedViewIndex { return }
        
        selectedViewIndex = selectedIndex
        setSelectedLine(index: selectedViewIndex)
        collectionView.selectItem(
            at: IndexPath(item: selectedViewIndex, section: 0),
            animated: true,
            scrollPosition: .centeredHorizontally)
    }
    
    @objc private func previousButtonPressed() {
        var selectedIndex = selectedViewIndex - 1
        
        if selectedIndex < 0 {
            selectedIndex += 1
        }
        
        // Prevent selecting the same item multiple times, causing jittery when spamming previous button
        if selectedIndex == selectedViewIndex { return }
        
        selectedViewIndex = selectedIndex
        setSelectedLine(index: selectedViewIndex)
        collectionView.selectItem(
            at: IndexPath(item: selectedViewIndex, section: 0),
            animated: true,
            scrollPosition: .centeredHorizontally)
    }
    
    // Snap cell on finished swiping
    private func setSelectedCellOnEndSwipe(scrollViewOffset: CGFloat, cellWidth: CGFloat) {
        
        if scrollViewOffset > cellWidth * 1.5 {
            selectedViewIndex = 2
        } else if scrollViewOffset > cellWidth * 0.5 {
            selectedViewIndex = 1
        } else {
            selectedViewIndex = 0
        }
        
        setSelectedLine(index: selectedViewIndex)
        collectionView.selectItem(
            at: IndexPath(item: selectedViewIndex, section: 0),
            animated: true,
            scrollPosition: .centeredHorizontally)
    }
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onboardingImagesName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as? OnboardingCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let image = UIImage(named: onboardingImagesName[indexPath.row]) {
            cell.configureImage(image: image)
        }
        
        if indexPath.row == 0, let image = UIImage(named: "Lamp") {
            cell.configureSecondaryImage(image: image)
        } else {
            cell.configureSecondaryImage(image: nil)
        }
        
        cell.configureHeaderLabel(with: onboardingTexts[indexPath.row].0)
        cell.configureSubheaderLabel(with: onboardingTexts[indexPath.row].1)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numOfColum = CGFloat(1)
        let collectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spacing = (collectionViewFlowLayout.minimumInteritemSpacing * CGFloat(numOfColum - 1)) + collectionViewFlowLayout.sectionInset.left + collectionViewFlowLayout.sectionInset.right
        let width = (collectionView.frame.size.width / numOfColum ) - spacing
        
        return CGSize(width: width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // Snap cell on will begin decelerating
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let itemWidth = collectionView.bounds.width
        let offset = scrollView.contentOffset.x
        setSelectedCellOnEndSwipe(scrollViewOffset: offset, cellWidth: itemWidth)
    }
    
    // Snap cell on will end dragging
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let itemWidth = collectionView.bounds.width
        let offset = scrollView.contentOffset.x
        setSelectedCellOnEndSwipe(scrollViewOffset: offset, cellWidth: itemWidth)
    }
}
