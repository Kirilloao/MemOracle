//
//  ViewController.swift
//  MemOracle
//
//  Created by Kirill Taraturin on 24.11.2023.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    // MARK: - Private UI Properties
    private var mainView = MainView()
    
    // MARK: - Private Properties
    private let networkManager = NetworkManager.shared
    private var memes: [Meme] = []
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMemes(with: Link.api.rawValue)
        setViews()
        setupConstraints()
        
        mainView.alertAction = {
            self.showAlert()
        }
        
        fetchNewMem()
        addToFavorites()
        setupNavigationBar()
    }
    
    // MARK: - Private Actions
    @objc private func refreshButtonDidTapped() {
        mainView.resetDataInScreen()
    }
    
    // MARK: - Private Methods
    private func addToFavorites() {
        mainView.predictionAction = { prediction in
            guard let tabBarController = self.tabBarController else { return }
            
            if let viewControllers = tabBarController.viewControllers {
                for viewController in viewControllers {
                    if let navigationController = viewController as? UINavigationController,
                       let listVC = navigationController.viewControllers.first as? ListViewController {
                        listVC.mems.append(prediction)
                        listVC.updateTableView()
                        break
                    }
                }
            }
        }
    }
    
    private func showMemes() {
        mainView.buttonAction = { [weak self] in
            self?.mainView.changeVisibleToMemes()
        }
        
        let threeMemes = Array(memes.map { $0.url  }
            .shuffled()
            .prefix(3))
        
        var dataMemes: [Data] = []
        
        let dispatchGroup = DispatchGroup() // Cоздаем группу
        
        threeMemes.forEach { url in
            dispatchGroup.enter() // Входим в группу перед началом запроса
            networkManager.fetchImage(from: url) { result in
                defer { dispatchGroup.leave() } // Указываем, что запрос завершен
                switch result {
                    
                case .success(let data):
                    dataMemes.append(data)
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) { // Вызывается после завершения всех запросов
            self.mainView.configure(imagesData: dataMemes)
        }
    }
    
    private func fetchNewMem() {
        mainView.newMemAction = {
            guard let randomMemURL = self.memes.randomElement()?.url else { return }
            
            self.networkManager.fetchImage(from: randomMemURL) { result in
                DispatchQueue.main.async {
                    switch result {
                        
                    case .success(let data):
                        self.mainView.getNewMem(data)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
    
    private func showAlert() {
        let alertController = UIAlertController(
            title: "Write your question",
            message: "",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        
        present(alertController, animated: true)
    }
}

// MARK: - Networking
extension MainViewController {
    private func fetchMemes(with url: String) {
        networkManager.fetch(with: url) { result in
            switch result {
            case .success(let mem):
                self.memes = mem.data.memes
                self.showMemes()
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Set Views
extension MainViewController {
    private func setViews() {
        view.backgroundColor = .white
        view.addSubview(mainView)
    }
    
    private func setupConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setupNavigationBar() {
        let refreshButton = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(refreshButtonDidTapped)
        )
        refreshButton.tintColor = .black
        
        navigationItem.rightBarButtonItem = refreshButton
    }
}

