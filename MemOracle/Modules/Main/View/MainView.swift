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
    var alertAction: (() -> Void)?
    
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
        return stackView
    }()
    
    private lazy var firstPredictionImageView: UIImageView = {
        var firstIV = UIImageView.createCustomImageView()
        return firstIV
    }()
    
    private lazy var secondPredictionImageView: UIImageView = {
        var secontIV = UIImageView.createCustomImageView()
        return secontIV
    }()
    
    private lazy var thirdPredictionImageView: UIImageView = {
        var thirdIV = UIImageView.createCustomImageView()
        return thirdIV
    }()
    
    private lazy var onePlugView: UIView = {
        var onePlug = UIView.makePlugView(with: self, and: #selector(showFirstMem))
        return onePlug
    }()
    
    private lazy var twoPlugView: UIView = {
        var twoPlug = UIView.makePlugView(with: self, and: #selector(showSecondMem))
        return twoPlug
    }()
    
    private lazy var threePlugView: UIView = {
        var threePlug = UIView.makePlugView(with: self, and: #selector(showThirdMem))
        return threePlug
    }()
    
    private lazy var acceptView: UIView = {
        var accept = UIView.makeViewForButton(with: .systemGreen)
        return accept
    }()
    
    private lazy var newMemView: UIView = {
        var newMem = UIView.makeViewForButton(with: .systemRed)
        return newMem
    }()
    
    private lazy var acceptButton: UIButton = {
        let resizedImage = self.resizeImage(image: "hand.thumbsup.fill")
        let accept = UIButton.makeCustomButton(
            with: resizedImage ?? UIImage(),
            and: .systemGreen
        )
        return accept
    }()
    
    private lazy var newMemButton: UIButton = {
        let resizedImage = self.resizeImage(image: "hand.thumbsdown.fill")
        let newMem = UIButton.makeCustomButton(
            with: resizedImage ?? UIImage(),
            and: .systemRed
        )
        return newMem
    }()
    
    // MARK: - Private Properties
    private var currentImages = [String: UIImageView]()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setupConstraints()
        currentImages = [
            "FirstImage": firstPredictionImageView,
            "SecondImage" :secondPredictionImageView,
            "ThirdImage" : thirdPredictionImageView
        ]
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
        questionTextField.text != "" ? buttonAction?() : showAlert()
    }
    
    @objc private func showFirstMem() {
        onePlugView.isHidden = true
        thirdPredictionImageView.isHidden = true
        secondPredictionImageView.isHidden = true
        
        currentImages.removeValue(forKey: "SecondImage")
        currentImages.removeValue(forKey: "ThirdImage")
        
        print(currentImages)
    }
    
    @objc private func showSecondMem() {
        twoPlugView.isHidden = true
        firstPredictionImageView.isHidden = true
        thirdPredictionImageView.isHidden = true
        
        currentImages.removeValue(forKey: "FirstImage")
        currentImages.removeValue(forKey: "ThirdImage")
        
        print(currentImages)
    }
    
    @objc private func showThirdMem() {
        threePlugView.isHidden = true
        firstPredictionImageView.isHidden = true
        secondPredictionImageView.isHidden = true
        
        currentImages.removeValue(forKey: "FirstImage")
        currentImages.removeValue(forKey: "SecondImage")
        
        print(currentImages)
    }
    
    // MARK: - Private Methods
    private func showAlert() {
        alertAction?()
    }
    
    
}

// MARK: - Setup Views
extension MainView {
    private func setViews() {
        addSubview(mainLabel)
        addSubview(questionTextField)
        addSubview(predictionButton)
        addSubview(imagesStackView)
        
        firstPredictionImageView.addSubview(onePlugView)
        secondPredictionImageView.addSubview(twoPlugView)
        thirdPredictionImageView.addSubview(threePlugView)
        
        addSubview(acceptView)
        acceptView.addSubview(acceptButton)
        
        addSubview(newMemView)
        newMemView.addSubview(newMemButton)
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
        
        onePlugView.snp.makeConstraints { $0.edges.equalToSuperview() }
        twoPlugView.snp.makeConstraints { $0.edges.equalToSuperview() }
        threePlugView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        acceptView.snp.makeConstraints { make in
            make.top.equalTo(imagesStackView.snp.bottom).offset(80)
            make.left.equalTo(imagesStackView.snp.left).offset(80)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        
        acceptButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        newMemView.snp.makeConstraints { make in
            make.top.equalTo(imagesStackView.snp.bottom).offset(80)
            make.right.equalTo(imagesStackView.snp.right).offset(-80)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        
        newMemButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func resizeImage(image: String) -> UIImage? {
        if let image = UIImage(systemName: image) {
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40))
            return renderer.image { (context) in
                image.draw(in: CGRect(origin: .zero, size: CGSize(width: 40, height: 40)))
            }
        } else {
            return UIImage()
        }
    }
}
