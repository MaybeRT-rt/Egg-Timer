//
//  EggTimerView.swift
//  Egg Timer
//
//  Created by Liz-Mary on 02.11.2023.
//

import Foundation
import UIKit

protocol EggTimerDelegate: AnyObject {
    func softEggTapped(_ sender: UIButton)
    func mediumEggTapped(_ sender: UIButton)
    func hardEggTapped(_ sender: UIButton)
}

class EggTimerView: UIView {
    
    weak var delegate: EggTimerDelegate?
    
    // MARK: - UI

    lazy var mainStack = UIStackView(arrangedSubviews: [titleLabel, eggsStack, timerView], axis: .vertical, spacing: 0, distribution: .fillEqually)
    
    lazy var eggsStack = UIStackView(arrangedSubviews: [softEggStack, mediumEggStack, hardEggStack], axis: .horizontal, spacing: 10, distribution: .fillEqually)
  
    
    var titleLabel = UILabel(text: "How do you like your eggs?", font: .systemFont(ofSize: 25))
    
    var softEggLabel = UILabel(text: "Soft", font: .systemFont(ofSize: 20))
    var mediumEggLabel = UILabel(text: "Medium", font: .systemFont(ofSize: 20))
    var hardEggLabel = UILabel(text: "Hard", font: .systemFont(ofSize: 20))
    
    lazy var softEgg: UIImageView = {
        let image = UIImageView(imageName: "soft_egg")
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(softEggTapped))
        image.addGestureRecognizer(tapGestureRecognizer)
        
        return image
    }()
    
    lazy var mediumEgg: UIImageView = {
        let image = UIImageView(imageName: "medium_egg")
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(mediumEggTapped))
        image.addGestureRecognizer(tapGestureRecognizer)
        
        return image
    }()
    
    lazy var hardEgg: UIImageView = {
        let image = UIImageView(imageName: "hard_egg")
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hardEggTapped))
        image.addGestureRecognizer(tapGestureRecognizer)
        
        return image
    }()
     
    lazy var softEggStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [softEgg, softEggLabel], axis: .vertical, spacing: 0, distribution: .fill)
        stack.alignment = .center
        return stack
    }()
    
    lazy var mediumEggStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [mediumEgg, mediumEggLabel], axis: .vertical, spacing: 0, distribution: .fill)
        stack.alignment = .center
        return stack
    }()
    
    lazy var hardEggStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [hardEgg, hardEggLabel], axis: .vertical, spacing: 0, distribution: .fill)
        stack.alignment = .center
        return stack
    }()
    
    lazy var timerView: UIView = {
        let timerView = UIStackView()
        timerView.translatesAutoresizingMaskIntoConstraints = false
        return timerView
    }()
    
    lazy var progressBar: UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.backgroundColor = .systemBlue
        progressBar.progressTintColor = .orange
        return progressBar
    }()
    
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func animateImageTapped(imageView: UIImageView, label: UILabel) {
        UIView.animate(withDuration: 0.2, animations: {
            imageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            label.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { _ in
            UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseInOut, animations: {
                imageView.transform = .identity
                label.transform = .identity
            }, completion: nil)
        }
    }
    
    
    @objc func softEggTapped(_ sender: UIButton) {
        animateImageTapped(imageView: softEgg, label: softEggLabel)
        guard let labelText = softEggLabel.text else { return }
        titleLabel.text = "You should \(labelText)"
        delegate?.softEggTapped(sender)
    }
    
    @objc func mediumEggTapped(_ sender: UIButton) {
        animateImageTapped(imageView: mediumEgg, label: mediumEggLabel)
        guard let labelText = mediumEggLabel.text else { return }
        titleLabel.text = "You should \(labelText)"
        delegate?.mediumEggTapped(sender)
    }
    
    @objc func hardEggTapped(_ sender: UIButton) {
        animateImageTapped(imageView: hardEgg, label: hardEggLabel)
        guard let labelText = hardEggLabel.text else { return }
        titleLabel.text = "You should \(labelText)"
        delegate?.hardEggTapped(sender)
    }

}

// MARK: - Setup View and Constraints

extension EggTimerView {
    
    func setupUI() {
        addSubview(mainStack)
        timerView.addSubview(progressBar)
        
        softEgg.heightAnchor.constraint(equalToConstant: 160).isActive = true
        mediumEgg.heightAnchor.constraint(equalToConstant: 160).isActive = true
        hardEgg.heightAnchor.constraint(equalToConstant: 160).isActive = true
    }
    
}
