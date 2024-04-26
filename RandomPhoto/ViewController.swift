//
// ViewController.swift
// Random Photo
//
// Created by Muhammad Osama Noor on 26/4/24

import UIKit

class ViewController: UIViewController {

    private let appBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Random Photo Generator"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        return imageView
    }()

    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Click Here", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let colors : [UIColor] = [
        .systemRed,
        .systemBlue,
        .systemGray,
        .systemMint,
        .systemYellow,
        .systemOrange
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        
        // Add app bar
        view.addSubview(appBarView)
        appBarView.addSubview(titleLabel)
        
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        imageView.center = view.center
        view.addSubview(button)
        getRandomPhoto()
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let appBarHeight: CGFloat = 100
        appBarView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: appBarHeight)
        titleLabel.frame = CGRect(x: 20, y: view.safeAreaInsets.top, width: view.frame.width - 40, height: appBarHeight - view.safeAreaInsets.top)
        
        button.frame = CGRect(x: 20, y: view.frame.height - 100 - view.safeAreaInsets.bottom, width: view.frame.width - 60, height: 55)
    }

        @objc private func didTapButton() {
        getRandomPhoto()
            view.backgroundColor = colors.randomElement()
    }
    
    func getRandomPhoto() {
        let urlString = "https://source.unsplash.com/random/600x600"
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching image: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }
        task.resume()
    }
}
