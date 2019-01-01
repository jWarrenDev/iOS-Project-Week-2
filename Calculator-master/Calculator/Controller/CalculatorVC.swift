//
//  CalculatorVC.swift
//  Calculator
//

import UIKit
import SnapKit

 class CalculatorVC: UIViewController {
    
    fileprivate enum OperatorType {
        case equal, clear, cancel, function
        
        var action: Int {
            switch self {
            case .equal: return -2
            case .clear: return -3
            case .cancel: return -4
            case .function: return -1
            }
        }
    }
    
    fileprivate var isOperationLocked = false
    fileprivate var operations = [String]() {
        didSet {
            operations.reverse()
            self.tableView.reloadData()
        }
    }
    
    fileprivate lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    fileprivate lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    fileprivate lazy var resultView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    fileprivate lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura-Bold", size: 40)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    fileprivate lazy var equalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura-Bold", size: 40)
        label.textColor = .red
        label.textAlignment = .center
        label.text = "="
        return label
    }()
    
    fileprivate var initialResult = "0.0" {
        didSet {
            resultLabel.text = initialResult
        
            if initialResult.isEmpty {
                resultLabel.text = "0.0"
                initialResult = "0.0"
            }
        }
    }
    
    fileprivate var safeArea: UILayoutGuide!
    
    fileprivate let tableView = UITableView()
    
    fileprivate let multiplyButton = CalcButton(op: "*", color: .green, tag: -1)
    fileprivate let additionButton = CalcButton(op: "+", color: .green, tag: -1)
    fileprivate let subtractionButton = CalcButton(op: "-", color: .green, tag: -1)
    fileprivate let divisionButton = CalcButton(op: "/", color: .green, tag: -1)
    fileprivate let zeroButton = CalcButton(op: "0", tag: 0)
    fileprivate let equalButton = CalcButton(op: "=", color: Appearance.red.color, tag: OperatorType.equal.action)
    fileprivate let cancelButton = CalcButton(op: "AC", color: .yellow, tag: OperatorType.clear.action)
    fileprivate let percentButton = CalcButton(op: "C", color: .yellow , tag: OperatorType.cancel.action)
    fileprivate let decimalButton = CalcButton(op: ".", tag: -1)
    
    fileprivate lazy var numberButtons: [CalcButton] = {
        let buttons = self.createNumberButtons(numbers: [1,2,3,4,5,6,7,8,9])
        return buttons
    }()
    fileprivate lazy var allCalculatorButtons: [CalcButton] = {
        var buttons = [self.cancelButton,
                       self.percentButton,
                       self.zeroButton,
                       self.additionButton,
                       self.subtractionButton,
                       self.divisionButton,
                       self.decimalButton,
                       self.equalButton,
                       self.multiplyButton,
                       
        ]
        for btn in self.numberButtons {
            buttons.append(btn)
        }
        return buttons
    }()
    
    fileprivate let lockOperations = [".", "*", "+", "-", "/"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        self.navigationItem.title = "Calculator"
        self.tabBarController?.title = "Calculator"
    }
    
    func createNumberButtons(numbers: [Int]) -> [CalcButton] {
        var buttons = [CalcButton]()
        for number in numbers {
            buttons.append(CalcButton(op: "\(number)", tag: number))
        }
        return buttons
    }
    
    func configureView(){
        safeArea = view.safeAreaLayoutGuide
        setupViews()
        setupButtons()
        setupResultLabel()
        setupOperationsTableView()
        setupSelectors()
    }
    
    func setupViews(){
        view.backgroundColor = .white
        
        view.addSubview(topView)
        topView.snp.makeConstraints{ make in
            make.top.equalTo(safeArea.snp.top)
            make.left.right.equalTo(safeArea)
            make.height.equalTo(safeArea).multipliedBy(0.4)
        }
        
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints{ make in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.equalTo(safeArea)
            make.height.equalTo(safeArea).multipliedBy(0.6)
        }
        
        addGradientMask(to: self.view)
    }
    
    func addGradientMask(to view: UIView){
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.25, y: 0.07)
        
        view.layer.mask = gradient
    }
    
    func setupButtons(){
        bottomView.addSubview(zeroButton)
        zeroButton.snp.makeConstraints{ make in
            make.left.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
            make.width.equalToSuperview().multipliedBy(0.50)
        }
        
        bottomView.addSubview(decimalButton)
        decimalButton.snp.makeConstraints{ make in
            make.left.equalTo(zeroButton.snp.right).offset(2)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalTo(zeroButton)
        }
        
        bottomView.addSubview(equalButton)
        equalButton.snp.makeConstraints{ make in
            make.bottom.equalToSuperview()
            make.left.equalTo(decimalButton.snp.right).offset(2)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        
        
        bottomView.addSubview(additionButton)
        additionButton.snp.makeConstraints{ make in
            make.bottom.equalTo(equalButton.snp.top).offset(-2)
            make.left.equalTo(decimalButton.snp.right).offset(2)
            make.height.equalToSuperview().multipliedBy(0.2).offset(-2)
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        
        bottomView.addSubview(subtractionButton)
        subtractionButton.snp.makeConstraints{ make in
            make.bottom.equalTo(additionButton.snp.top).offset(-2)
            make.left.equalTo(decimalButton.snp.right).offset(2)
            make.height.equalToSuperview().multipliedBy(0.2).offset(-2)
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        
        bottomView.addSubview(divisionButton)
        divisionButton.snp.makeConstraints{ make in
            make.bottom.equalTo(subtractionButton.snp.top).offset(-2)
            make.left.equalTo(decimalButton.snp.right).offset(2)
            make.height.equalToSuperview().multipliedBy(0.2).offset(-2)
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        
        bottomView.addSubview(multiplyButton)
        bottomView.layer.borderWidth = 1
        multiplyButton.snp.makeConstraints{ make in
            make.bottom.equalTo(divisionButton.snp.top).offset(-2)
            make.left.equalTo(decimalButton.snp.right).offset(2)
            make.height.equalToSuperview().multipliedBy(0.2).offset(-2)
            make.width.equalToSuperview().multipliedBy(0.25)
            
        }
        
        
     
        bottomView.addSubview(numberButtons[2])
        numberButtons[2].snp.makeConstraints{ make in
            make.left.equalTo(zeroButton.snp.right).offset(2)
            make.bottom.equalTo(decimalButton.snp.top).offset(-2)
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalToSuperview().multipliedBy(0.2).offset(-2)
        }
        
        bottomView.addSubview(numberButtons[5])
        numberButtons[5].snp.makeConstraints{ make in
            make.left.equalTo(zeroButton.snp.right).offset(2)
            make.bottom.equalTo(numberButtons[2].snp.top).offset(-2)
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalToSuperview().multipliedBy(0.2).offset(-2)
        }
        
        bottomView.addSubview(numberButtons[8])
        numberButtons[8].snp.makeConstraints{ make in
            make.left.equalTo(zeroButton.snp.right).offset(2)
            make.bottom.equalTo(numberButtons[5].snp.top).offset(-2)
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalToSuperview().multipliedBy(0.2).offset(-2)
        }
        
        bottomView.addSubview(percentButton)
        percentButton.snp.makeConstraints{ make in
            make.left.equalTo(zeroButton.snp.right).offset(2)
            make.bottom.equalTo(numberButtons[8].snp.top).offset(-2)
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalToSuperview().multipliedBy(0.2).offset(-2)
        }
        
        // Column One
        bottomView.addSubview(numberButtons[0])
        numberButtons[0].snp.makeConstraints{ make in
            make.left.equalToSuperview()
            make.bottom.equalTo(decimalButton.snp.top).offset(-2)
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalToSuperview().multipliedBy(0.2).offset(-2)
        }
        
        bottomView.addSubview(numberButtons[3])
        numberButtons[3].snp.makeConstraints{ make in
            make.left.equalToSuperview()
            make.bottom.equalTo(numberButtons[0].snp.top).offset(-2)
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalToSuperview().multipliedBy(0.2).offset(-2)
        }
        
        bottomView.addSubview(numberButtons[6])
        numberButtons[6].snp.makeConstraints{ make in
            make.left.equalToSuperview()
            make.bottom.equalTo(numberButtons[3].snp.top).offset(-2)
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalToSuperview().multipliedBy(0.2).offset(-2)
        }
        
        bottomView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints{ make in
            make.left.equalToSuperview()
            make.bottom.equalTo(numberButtons[6].snp.top).offset(-2)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview().multipliedBy(0.2).offset(-2)
        }
        
        bottomView.addSubview(numberButtons[1])
        numberButtons[1].snp.makeConstraints{ make in
            make.right.equalTo(zeroButton.snp.right)
            make.bottom.equalTo(decimalButton.snp.top).offset(-2)
            make.width.equalToSuperview().multipliedBy(0.25).offset(-2)
            make.height.equalToSuperview().multipliedBy(0.2).offset(-2)
        }
        
        bottomView.addSubview(numberButtons[4])
        numberButtons[4].snp.makeConstraints{ make in
            make.right.equalTo(zeroButton.snp.right)
            make.bottom.equalTo(numberButtons[1].snp.top).offset(-2)
            make.width.equalToSuperview().multipliedBy(0.25).offset(-2)
            make.height.equalToSuperview().multipliedBy(0.2).offset(-2)
        }
        
        bottomView.addSubview(numberButtons[7])
        numberButtons[7].snp.makeConstraints{ make in
            make.right.equalTo(zeroButton.snp.right)
            make.bottom.equalTo(numberButtons[4].snp.top).offset(-2)
            make.width.equalToSuperview().multipliedBy(0.25).offset(-2)
            make.height.equalToSuperview().multipliedBy(0.2).offset(-2)
        }
    }
    
    func setupOperationsTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OperationTableViewCell.self)
        topView.addSubview(tableView)
        tableView.snp.makeConstraints{ make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(resultLabel.snp.top).offset(4)
        }
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi));
        tableView.backgroundColor = Appearance.bg.color
    }
    
    func setupResultLabel(){
        topView.addSubview(equalLabel)
        equalLabel.snp.makeConstraints{ make in
            make.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.1)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.bottom.equalToSuperview()
        }
        
        topView.addSubview(resultLabel)
        resultLabel.snp.makeConstraints{ make in
            make.right.equalToSuperview().inset(4)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.bottom.equalToSuperview()
            make.left.equalTo(equalLabel.snp.right)
        }
        resultLabel.text = initialResult
    }
}


extension CalculatorVC {
    @objc func performOperation(_ sender: CalcButton){
        sender.zoomIn()
        
        if initialResult.utf8CString.count == 10 {
            initialResult = "0.0"
        }
        equalLabel.isHidden = true
        if sender.tag == OperatorType.equal.action {
            doMath()
        }else if sender.tag == OperatorType.clear.action {
            if initialResult == "0.0" { operations.removeAll() }
            initialResult = "0.0"
        }else if sender.tag == OperatorType.cancel.action {
            initialResult = "\(initialResult.dropLast())"
        }else if lockOperations.contains((initialResult.utf8CString.last?.description)!) && sender.tag == -1 {
            return
        }else if sender.tag == -1 && initialResult == "0.0" {
            return
        } else if sender.tag >= -1 {
            if initialResult == "0.0" && !equalButton.isHidden {
                initialResult = sender.operation
            }else {
                initialResult = initialResult.appending(sender.operation)
            }
        }
        
        tableView.scrollsToTop = true
    }
    
    func setupSelectors(){
        for btn in allCalculatorButtons {
            btn.addTarget(self, action: #selector(performOperation(_:)), for: .touchUpInside)
        }
    }
    
    // NSExpression!
    func doMath(){
        equalLabel.isHidden = !equalLabel.isHidden
        guard initialResult != "0.0" else { return }
        operations.append(initialResult)
        let expression = NSExpression(format: initialResult)
        guard let mathValue = expression.expressionValue(with: nil, context: nil) as? Double else { return }
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 6
        guard let value = formatter.string(from: NSNumber(value: mathValue)) else { return }
        initialResult = value 
    }
}


// Mark: - Delegate

extension CalculatorVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as OperationTableViewCell
        cell.label.text = operations[indexPath.row]
        cell.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi));
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45 //
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operations.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? OperationTableViewCell,
            let operation = cell.label.text else { return }
        initialResult = operation
    }
   
}














