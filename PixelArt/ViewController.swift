//
//  ViewController.swift
//  PixelArt
//
//  Created by Anurag Pandit on 29/09/24.
//

import UIKit

struct MainHeader {
    private let title: String
    init(title: String) {
        self.title = title
    }
    func getTitle() -> String {
        title
    }
    func getFont() -> UIFont {
        .systemFont(ofSize: 48, weight: .bold)
    }
}

struct MainViewModel {
    let mainHeader = MainHeader(title: "PixelArt")
}
typealias ButtonTapped = (UIAction?)

class ViewController: UIViewController  {
    private let viewModel = MainViewModel()
    private let headerView: UIView = {
        let hView = UIView()
        hView.layer.backgroundColor = UIColor.orange.cgColor
        hView.layer.shadowColor = UIColor.white.cgColor
        hView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        hView.layer.shadowOpacity = 0.2
        hView.layer.shadowRadius = 4.0
        hView.layer.cornerRadius = 6
        hView.layer.masksToBounds = true
        hView.translatesAutoresizingMaskIntoConstraints = false
        return hView
    }()
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let actionContainerView: UIView = {
       let hView = UIView()
        hView.layer.backgroundColor = UIColor.lightGray.cgColor
        hView.layer.shadowColor = UIColor.white.cgColor
        hView.layer.shadowOffset = CGSize(width: 0, height: 8.0)
        hView.layer.shadowOpacity = 0.2
        hView.layer.shadowRadius = 4.0
        hView.layer.cornerRadius = 6
        hView.layer.masksToBounds = true
        hView.translatesAutoresizingMaskIntoConstraints = false
        return hView
    }()
    
    private let collectionContainerView: UIView = {
       let hView = UIView()
        hView.layer.backgroundColor = UIColor.lightGray.cgColor
        hView.layer.shadowColor = UIColor.white.cgColor
        hView.layer.shadowOffset = CGSize(width: 0, height: 8.0)
        hView.layer.shadowOpacity = 0.2
        hView.layer.shadowRadius = 4.0
        hView.layer.cornerRadius = 6
        hView.layer.masksToBounds = true
        hView.translatesAutoresizingMaskIntoConstraints = false
        return hView
    }()
    
    private let cameraButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Camera", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let galleryButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Gallery", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let hStack: UIStackView = {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.distribution = .fillEqually
        hStack.spacing = 10
        hStack.translatesAutoresizingMaskIntoConstraints = false
        return hStack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupHeaderView()
        setupActionContainerView()
        setupCollectionContainerView()
        configureActionView()
    }
}
private
extension ViewController {
    func setupHeaderView() {
        view.addSubview(headerView)
        headerView.addSubview(headerLabel)
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([headerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
                                     headerView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
                                     headerView.heightAnchor.constraint(equalToConstant: 64),
                                     
                                     headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
                                     headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)])
        headerLabel.text = viewModel.mainHeader.getTitle()
        headerLabel.font = viewModel.mainHeader.getFont()
    }
}

private
extension ViewController {
    func setupActionContainerView() {
        view.addSubview(actionContainerView)
        NSLayoutConstraint.activate([actionContainerView.topAnchor.constraint(equalTo: headerView.bottomAnchor,
                                                                              constant: 16),
                                     actionContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                                                  constant: 16),
                                     actionContainerView.trailingAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.trailingAnchor,
                                                                                   constant: -16),
                                     actionContainerView.heightAnchor.constraint(equalToConstant: 54)])
        
    }
    func configureActionView() {
        actionContainerView.addSubview(hStack)
        hStack.addArrangedSubview(cameraButton)
        hStack.addArrangedSubview(galleryButton)
        cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
        galleryButton.addTarget(self, action: #selector(galleryButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            hStack.centerXAnchor.constraint(equalTo: actionContainerView.centerXAnchor),
            hStack.centerYAnchor.constraint(equalTo: actionContainerView.centerYAnchor),
            hStack.leadingAnchor.constraint(equalTo: actionContainerView.leadingAnchor, constant: 20),
            hStack.trailingAnchor.constraint(equalTo: actionContainerView.trailingAnchor, constant: -20)
        ])
    }
    @objc 
    func cameraButtonTapped() {
        print("cameraButtonTapped!")
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("camera unavailable!")
            return
        }
        let cameraPickerUV = UIImagePickerController()
        cameraPickerUV.delegate = self
        cameraPickerUV.sourceType = .camera
        // TODO: show loader
        present(cameraPickerUV, animated: true) {
            // dismiss the loader
        }
    }
    
    @objc 
    func galleryButtonTapped() {
        print("galleryButtonTapped!")
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("photoLibrary unavailable!")
            return
        }
        let photoPickerUV = UIImagePickerController()
        photoPickerUV.delegate = self
        photoPickerUV.sourceType = .photoLibrary
        // TODO: show loader
        present(photoPickerUV, animated: true) {
            // dismiss the loader
        }
    }
}
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo
                               info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            print("Image selected: \(selectedImage)")
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

private
extension ViewController {
    func setupCollectionContainerView() {
        view.addSubview(collectionContainerView)
        NSLayoutConstraint.activate([collectionContainerView.topAnchor
            .constraint(equalTo: actionContainerView.bottomAnchor, constant: 16),
                                     collectionContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                                     collectionContainerView.trailingAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                                     collectionContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
        
    }
}
