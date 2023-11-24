//
//  MainView.swift
//  MemOracle
//
//  Created by Kirill Taraturin on 24.11.2023.
//

import UIKit

final class MainView: UIView {
    
    // MARK: - Closures
    var buttonAction: (() -> Void)?
    var imageFetch: (([String]) -> [Data])?
    
    // MARK: - Private UI Properties
    private lazy var mainLabel: UILabel = {
        var label = UILabel()
        label.text = "What is your question?"
        return label
    }()
    
    private lazy var questionTextField: UITextField = {
        var questionTF = UITextField()
        questionTF.borderStyle = .roundedRect
        questionTF.placeholder = "Enter your question here"
        return questionTF
    }()
    
    private lazy var predictionButton: UIButton = {
        var predButton = UIButton(type: .system)
        predButton.setTitle("Get a prediction", for: .normal)
        predButton.addTarget(
            self,
            action: #selector(predictionButtonDidTapped),
            for: .touchUpInside
        )
        return predButton
    }()
    
    private lazy var imagesStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(firstPredictionImageView)
        stackView.addArrangedSubview(secondPredictionImageView)
        stackView.addArrangedSubview(thirdPredictionImageView)
        stackView.isHidden = true
//        stackView.alpha = 0
        return stackView
    }()
    
    private lazy var firstPredictionImageView: UIImageView = {
        var firstIV = UIImageView()
        firstIV.image = UIImage(named: "default")
        firstIV.contentMode = .scaleToFill
        return firstIV
    }()
    
    private lazy var secondPredictionImageView: UIImageView = {
        var secondIV = UIImageView()
        secondIV.image = UIImage(named: "default")
        return secondIV
    }()
    
    private lazy var thirdPredictionImageView: UIImageView = {
        var thirdIV = UIImageView()
        thirdIV.image = UIImage(named: "default")
        return thirdIV
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(imagesData: [Data]) {
        let imagesData = imagesData
        let images = [
            firstPredictionImageView,
            secondPredictionImageView,
            thirdPredictionImageView
        ]
        
        for (data, image) in zip(imagesData, images) {
            image.image = UIImage(data: data)
        }
    }
    
    func changeVisibleToMemes() {
//        self.imagesStackView.isHidden.toggle()
        imagesStackView.isHidden = false

        if imagesStackView.alpha == 0 {
            imagesStackView.alpha = 1
 
        } else {
            imagesStackView.alpha = 0

        }
        
        UIView.animate(withDuration: 1.0) {
            self.imagesStackView.alpha = 1
        }
    }
    
    // MARK: - Private Actions
    @objc private func predictionButtonDidTapped() {
        buttonAction?()
    }

    // MARK: - Private Methods
    private func setViews() {
        addSubview(mainLabel)
        addSubview(questionTextField)
        addSubview(predictionButton)
        addSubview(imagesStackView)
    }
    
    private func setupConstraints() {
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        
        questionTextField.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        predictionButton.snp.makeConstraints { make in
            make.top.equalTo(questionTextField.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        
        imagesStackView.snp.makeConstraints { make in
            make.top.equalTo(predictionButton.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(180)
        }
    }
}
