//
//  PatientViewController.swift
//  BlockHeal
//
//  Created by ali on 6/17/20.
//  Copyright © 2020 Alireza. All rights reserved.
//

import UIKit
import Spring

class PatientViewController: BaseViewController {
    
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel2: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameLabel2: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var mainViewv: UIView!
    
    @IBOutlet weak var bigHeaderView: UIView!
    @IBOutlet weak var smallHeaderView: UIView!
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    
    
    var name: String! = "علیرضا طغیانی"
    var phoneNumber: String! = "09202072717"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mainViewv.roundCorners(corners: [.topLeft, .topRight], radius: 30)
        
    }
    
    
    
    override func configureViews() {
        phoneNumberLabel.text = phoneNumber.convertNumberToPersian()
        phoneNumberLabel2.text = phoneNumber.convertNumberToPersian()
        nameLabel2.text = name.convertNumberToPersian()
        nameLabel.text = name.convertNumberToPersian()
        //        tableView.selec
    }
    
    @IBAction func profileButtonDidTap(_ sender: Any) {
        
    }
    
}


extension PatientViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientTableViewCell", for: indexPath) as! PatientTableViewCell
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "نسخه‌ها"
            cell.iconImageView.image = UIImage(named: "prescripts")
        case 1:
            cell.titleLabel.text = "سوابق"
            cell.iconImageView.image = UIImage(named: "savabegh")
        case 2:
            cell.titleLabel.text = "درخواست‌های مشاهده سوابق"
            cell.iconImageView.image = UIImage(named: "requests")
        default:
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            SegueHelper.pushViewController(sourceViewController: self, destinationViewController: PrescriptionsViewController.instantiateFromStoryboardName(storyboardName: .Patient))
        case 1:
            SegueHelper.pushViewController(sourceViewController: self, destinationViewController: MedicalRecordsViewController.instantiateFromStoryboardName(storyboardName: .Patient))
        case 2:
            SegueHelper.pushViewController(sourceViewController: self, destinationViewController: RequestsViewController.instantiateFromStoryboardName(storyboardName: .Patient))
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = -scrollView.contentOffset.y
        //        let delta = abs(offsetY)
        print(offsetY)
        if offsetY < -20 {
            if !bigHeaderView.isHidden {
                UIView.animate(withDuration: 0.5) {
                    self.bigHeaderView.isHidden = true
                    self.smallHeaderView.isHidden = false
                    self.headerViewHeight.constant = 150
                    self.view.layoutIfNeeded()
                }
            }
        } else if offsetY >= 20 {
            if bigHeaderView.isHidden {
                UIView.animate(withDuration: 0.5) {
                    self.bigHeaderView.isHidden = false
                    self.smallHeaderView.isHidden = true
                    self.headerViewHeight.constant = 300
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    

    
}
