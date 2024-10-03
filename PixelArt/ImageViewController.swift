//
//  ImageViewController.swift
//  PixelArt
//
//  Created by Anurag Pandit on 03/10/24.
//
import UIKit
final class ImageViewController: UIViewController {
    private let contentView: UIView = {
        let cView = UIView()
        cView.layer.backgroundColor = UIColor.orange.cgColor
        cView.layer.shadowColor = UIColor.white.cgColor
        cView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cView.layer.shadowOpacity = 0.2
        cView.layer.shadowRadius = 4.0
        cView.layer.cornerRadius = 6
        cView.layer.masksToBounds = true
        cView.translatesAutoresizingMaskIntoConstraints = false
        return cView
    }()
    
    private let imageView: UIImageView = {
        let iView = UIImageView()
        iView.translatesAutoresizingMaskIntoConstraints = false
        return iView
    }()
    
    let selectedImage: UIImage
    init(selectedImage: UIImage) {
        self.selectedImage = selectedImage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureImageView()
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close,
                                          target: self, action: #selector(dismissViewController))
        navigationItem.leftBarButtonItem = closeButton
        navigationController?.navigationBar.backgroundColor = .white
    }
    // Action for the close button
    @objc func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
}
private
extension ImageViewController {
    func setupView() {
        setupContentView()
        setupImageView()
    }
    func setupContentView() {
        view.addSubview(contentView)
        NSLayoutConstraint.activate([contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                     contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)])
    }
    func setupImageView() {
        contentView.addSubview(imageView)
        imageView.backgroundColor = .red
        NSLayoutConstraint.activate([imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                                     imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                                     imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                                     imageView.heightAnchor.constraint(equalToConstant: 200)])
    }
    func configureImageView() {
        imageView.image = selectedImage
        imageView.sizeToFit()
    }
}
