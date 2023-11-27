//
//  UIView+ Extension.swift
//  MemOracle
//
//  Created by Kirill Taraturin on 25.11.2023.
//

import UIKit

final class QuestionView: UIView {
    
    // MARK: - Private UI Properties
    private lazy var questionView: UIView = {
        var questionView = UIView()
        questionView.backgroundColor = .black
        questionView.layer.cornerRadius = 10
        questionView.clipsToBounds = true
        return questionView
    }()
    
    private lazy var questionImageView: UIImageView = {
        var questionImage = UIImageView()
        questionImage.image = UIImage(systemName: "questionmark")
        questionImage.tintColor = .white
        return questionImage
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
    
    // MARK: - Private Methods
    private func setViews() {
        addSubview(questionView)
        questionView.addSubview(questionImageView)
    }
    
    private func setupConstraints() {
        questionView.snp.makeConstraints { $0.edges.equalToSuperview() }
        questionImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
}
