//
//  MainViewController.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 27.11.2021.
//  
//

import UIKit
import SnapKit

// MARK: MainPresenterToViewProtocol (Presenter -> View)
protocol MainPresenterToViewProtocol: AnyObject {

}

// MARK: MainRouterToViewProtocol (Router -> View)
protocol MainRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
}

class MainViewController: UIViewController {
    
    // MARK: - Property
    var presenter: MainViewToPresenterProtocol!
    
    private lazy var customController: CustomNavigationController = {
        let customController = CustomNavigationController(title: "News From Newsapi.org")
        
        return customController
    }()
    
    private lazy var backNewsButton: UIButton = {
        let button = UIButton()
        button.setTitle("<", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var searchInput: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.placeholder = "Поиск"
        textField.autocorrectionType = .no
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 15)
        return textField
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    private lazy var successButton: UIButton = {
        let button = UIButton()
        button.setTitle("Поиск", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(clickOnSuccessButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var dateFromInput: UITextField = createDateInput()
    private lazy var dateToInput: UITextField = createDateInput()
    private lazy var labelFromDateFromInput: UILabel = createTextLabel(text: "От:")
    private lazy var labelFromDateToInput: UILabel = createTextLabel(text: "До:")
    private lazy var labelFromSearchInput: UILabel = createTextLabel(text: "Введите фразу для поиска:")
    
    @objc private func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if dateFromInput.isEditing {
            dateFromInput.text = dateFormatter.string(from: datePicker.date)
        } else {
            dateToInput.text = dateFormatter.string(from: datePicker.date)
        }
        self.view.endEditing(true)
    }
    
    @objc private func clickOnSuccessButton() {
        var inputsData: [String : String] = [:]
        guard let searchInput = searchInput.text,
              let dateFromInput = dateFromInput.text,
              let dateToInput = dateToInput.text else { return }
        guard searchInput != "" && dateFromInput != "" && dateToInput != "" else {
            let alert = UIAlertController(title: "Ошибка", message: "Необходимо заполнить все поля", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Oк", style: .cancel, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return
        }
        inputsData["searchInput"] = searchInput
        inputsData["dateFromInput"] = dateFromInput
        inputsData["dateToInput"] = dateToInput
        presenter.clickOnSuccessButton(inputsData: inputsData)
    }

    // MARK: - init
    init() {
        super.init(nibName: nil, bundle: nil)

        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        presenter.viewDidLoad()
    }
    
    // MARK: - private func
    private func commonInit() {

    }

    private func configureUI() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(customController)
        customController.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview()
            make.height.equalTo(70)
        }
        
        self.view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.center.equalTo(self.view.center)
            make.width.equalTo(self.view.safeAreaLayoutGuide).multipliedBy(0.8)
        }
        stackView.addArrangedSubview(labelFromSearchInput)
        stackView.addArrangedSubview(searchInput)
        stackView.addArrangedSubview(labelFromDateFromInput)
        stackView.addArrangedSubview(dateFromInput)
        stackView.addArrangedSubview(labelFromDateToInput)
        stackView.addArrangedSubview(dateToInput)
        
        self.view.addSubview(successButton)
        successButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.centerX.equalTo(stackView)
            make.top.equalTo(stackView.snp.bottom).inset(-25)
        }
    }
    
    private func createDateInput() -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.placeholder = "Выберите дату"
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        textField.inputView = datePicker
        textField.inputAccessoryView = toolbar
        textField.font = UIFont.systemFont(ofSize: 15)
        
        return textField
    }
    
    private func createTextLabel(text: String) -> UILabel {
        let textLabel = UILabel()
        textLabel.text = text
        textLabel.textAlignment = .left
        textLabel.textColor = .black
        textLabel.font = .systemFont(ofSize: 15)
        return textLabel
    }
}

// MARK: MainPresenterToViewProtocol 
extension MainViewController: MainPresenterToViewProtocol{
    
}

// MARK: MainRouterToViewProtocol
extension MainViewController: MainRouterToViewProtocol{
    func presentView(view: UIViewController) {
        present(view, animated: true, completion: nil)
    }

    func pushView(view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
}
