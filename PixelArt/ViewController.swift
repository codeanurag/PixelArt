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

class ViewController: UIViewController {
    private let viewModel = MainViewModel()
    private let headerView: UIView = {
        let hView = UIView()
        hView.layer.backgroundColor = UIColor.orange.cgColor
        hView.layer.shadowColor = UIColor.black.cgColor
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderView()
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

