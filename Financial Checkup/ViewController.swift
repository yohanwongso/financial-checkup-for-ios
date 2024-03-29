//
//  ViewController.swift
//  Financial Checkup
//
//  Created by Yohan Wongso on 03/03/20.
//  Copyright © 2020 Yohan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var calculatorView: UIView!
    
    @IBOutlet weak var activeIncomeTextField: UITextField!
    @IBOutlet weak var passiveIncomeTextField: UITextField!
    @IBOutlet weak var debtPaymentTextField: UITextField!
    @IBOutlet weak var savingTextField: UITextField!
    
    @IBOutlet weak var spendingResult: UILabel!
    @IBOutlet weak var debtPaymentResult: UILabel!
    @IBOutlet weak var savingResult: UILabel!
    @IBOutlet weak var financialFreedomResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeSegmentedControlDidTab(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
//            print("Calculator")
            calculatorView.isHidden = false
            break
        case 1:
//            print("Result")
            calculatorView.isHidden = true
            break
        default:
            break
        }
    }
    
    @IBAction func clearButtonDidTab(_ sender: Any) {
        activeIncomeTextField.text = ""
        passiveIncomeTextField.text = ""
        debtPaymentTextField.text = ""
        savingTextField.text = ""
    }
    
    @IBAction func activeIncomeHelp(_ sender: Any) {
        let alert = UIAlertController(title: "Active Income", message: "Active income refers to income received from performing a service and includes wages, tips, salaries, commissions, and income from businesses in which there is material participation.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func passiveIncomeHelp(_ sender: Any) {
        let alert = UIAlertController(title: "Passive Income", message: "Passive income is income that requires little to no effort to earn and maintain.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func debtPaymentHelp(_ sender: Any) {
        let alert = UIAlertController(title: "Debt Payment", message: "The act of paying back money that you have borrowed", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func savingHelp(_ sender: Any) {
        let alert = UIAlertController(title: "Saving", message: "Saving is a part of income that you keep for the future", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func calculateButtonDidTab(_ sender: UIButton) {
//        Get value
        let activeIncome = unwrapStrToInt(activeIncomeTextField.text)
        let passiveIncome = unwrapStrToInt(passiveIncomeTextField.text)
        let debtPayment = unwrapStrToInt(debtPaymentTextField.text)
        let saving = unwrapStrToInt(savingTextField.text)
        let spending = (activeIncome + passiveIncome) - (debtPayment + saving)
        
//        validation
        if(activeIncome + passiveIncome == 0){
            let alert = UIAlertController(title: "No Income", message: "You have no income", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        if(activeIncome + passiveIncome < debtPayment + saving){
            let alert = UIAlertController(title: "Invalid Input", message: "Your total income is less than debt payment plus saving", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        var infinityFinancialFreedom = false
        if(spending + debtPayment == 0){
            infinityFinancialFreedom = true
        }
        
//        Generate report
        let spendingPercentage = 100 * spending / (activeIncome + passiveIncome)
        var report = "Your monthly spending is \(spendingPercentage)% of your monthly active & passive income."
        spendingResult.text = report

        let debtPaymentPercentage = 100 * debtPayment / (activeIncome + passiveIncome)
        report = "Your monthly debt payment is \(debtPaymentPercentage)% of your monthly active & passive income.\n"
        if(debtPaymentPercentage > 30){
            report += "IT'S NOT GOOD! Your monthly debt payment ratio is too huge so you need to keep it at 30% or less."
        }
        else{
            report += "NICE! Your debt ratio is in the safe zone."
        }
        debtPaymentResult.text = report

        let savingPercentage = 100 * saving / (activeIncome + passiveIncome)
        report = "Your monthly saving is \(savingPercentage)% of your monthly active & passive income.\n"
        if(savingPercentage < 20){
            report += "IT'S NOT GOOD! Your monthly saving ratio is too small so you need to keep it at 20% or more."
        }
        else{
            report += "GOOD JOB! You have a good saving ratio."
        }
        savingResult.text = report
        if(infinityFinancialFreedom == true){
            report = "CONGRATULATIONS! You achieved your financial freedom! Don't get bored to grow it more!"
        }
        else{
            let passiveIncomePercentage = 100 * passiveIncome / (spending + debtPayment)
            report = "Your monthly passive income is \(passiveIncomePercentage)% of your monthly spending & debt payment.\n"
            if(passiveIncomePercentage >= 100){
                report += "CONGRATULATIONS! You achieved your financial freedom! Don't get bored to grow it more!"
            }
            else if(passiveIncomePercentage >= 20){
                report += "GOOD JOB! You have a pasive income. Keep growing until you get your financial freedom!"
            }
            else{
                report += "IT'S NOT GOOD! You need to grow your passive income to achieve your financial freedom."
            }
        }
        financialFreedomResult.text = report
        
//        Change to result page
        segmentedControl.selectedSegmentIndex = 1
        calculatorView.isHidden = true
    }
    
    func unwrapStrToInt(_ arg : String?) -> Int{
        guard let temp1 = arg else {
            return 0
        }
        guard let temp2 = Int(temp1) else{
            return 0
        }
        return temp2
    }
    
}

