//
//  RequestsViewController.swift
//  BlockHeal
//
//  Created by ali on 6/18/20.
//  Copyright © 2020 Alireza. All rights reserved.
//

import UIKit
import Spring

struct MedicalCheckRequest {
    var doctorName: String
    var state: Bool?
}

class RequestsViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel2: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameLabel2: UILabel!
    
    @IBOutlet var mainViewv: UIView!
    
    @IBOutlet weak var bigHeaderView: UIView!
    @IBOutlet weak var smallHeaderView: UIView!
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    
    

    
    var requestList: [MedicalCheckRequest] = [
    MedicalCheckRequest(doctorName: "doc1", state: false),
    MedicalCheckRequest(doctorName: "doc2"),
    MedicalCheckRequest(doctorName: "doc3", state: true),
    MedicalCheckRequest(doctorName: "doc4", state: false),
    MedicalCheckRequest(doctorName: "مممسنییا", state: true),
    MedicalCheckRequest(doctorName: "مممسنییا", state: false),
    MedicalCheckRequest(doctorName: "مممسنییا", state: true),
    MedicalCheckRequest(doctorName: "doc5"),
    MedicalCheckRequest(doctorName: "مممسنییا", state: true),
    MedicalCheckRequest(doctorName: "مممسنییا", state: true),
    MedicalCheckRequest(doctorName: "مممسنییا", state: false),
    MedicalCheckRequest(doctorName: "doc6"),
    MedicalCheckRequest(doctorName: "dhdddkkd"),
    MedicalCheckRequest(doctorName: "مممسنییا"),
    MedicalCheckRequest(doctorName: "مممسنییا", state: false)
    ]
    
    var rejectedRequestList: [MedicalCheckRequest] = []
    var newRequestList: [MedicalCheckRequest] = []
    var acceptedRequestList: [MedicalCheckRequest] = []
    
    
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
        setupRequestLists()
        phoneNumberLabel.text = phoneNumber.convertNumberToPersian()
        phoneNumberLabel2.text = phoneNumber.convertNumberToPersian()
        nameLabel2.text = name.convertNumberToPersian()
        nameLabel.text = name.convertNumberToPersian()
        
    }
    
    override func doShakeFunction() {
        setupRequestLists()
    }
    
    func setupRequestLists(){
        Log.i()
        rejectedRequestList = []
        acceptedRequestList = []
        newRequestList = []
        for r in requestList {
            if let state = r.state {
                if state {
                    acceptedRequestList.append(r)
                } else {
                    rejectedRequestList.append(r)
                }
            } else {
                newRequestList.append(r)
            }
        }
        tableView.reloadData()
    }
    
    
    @IBAction func profileButtonDidTap(_ sender: Any) {
    }
    
    @IBAction func rejectButtonDidTap(_ sender: UIButton) {
        let index = sender.tag
        
        var item = newRequestList[index]
        
        newRequestList.remove(at: index)
        tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
        item.state = false
        rejectedRequestList.append(item)

     
        tableView.reloadData()
    }
    
    @IBAction func acceptButtonDidTap(_ sender: UIButton) {
           let index = sender.tag
              
              var item = newRequestList[index]
              
              newRequestList.remove(at: index)
              tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
              item.state = true
              acceptedRequestList.append(item)

           
              tableView.reloadData()
    }
}


extension RequestsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cellData =
        
        
        
        
        
        switch indexPath.section {
        case 0:
            let newRequestCell = tableView.dequeueReusableCell(withIdentifier: "NewRequestTableViewCell", for: indexPath) as! NewRequestTableViewCell
            let cellData = newRequestList[indexPath.row]
            
            newRequestCell.acceptButton.tag = indexPath.row
            newRequestCell.rejectButton.tag = indexPath.row
            newRequestCell.doctorNameLabel.text = cellData.doctorName

            return newRequestCell
        case 1:
            let acceptedRequestCell = tableView.dequeueReusableCell(withIdentifier: "AcceptedRequestTableViewCell", for: indexPath) as! AcceptedRequestTableViewCell
            let cellData = acceptedRequestList[indexPath.row]

            acceptedRequestCell.doctorNameLabel.text = cellData.doctorName

            return acceptedRequestCell
        case 2:
            let rejectedRequestCell = tableView.dequeueReusableCell(withIdentifier: "RejectedRequestTableViewCell", for: indexPath) as! RejectedRequestTableViewCell
            let cellData = rejectedRequestList[indexPath.row]

            rejectedRequestCell.doctorNameLabel.text = cellData.doctorName
            
            return rejectedRequestCell
        default:
            return UITableViewCell()
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return newRequestList.count
        case 1:
            return acceptedRequestList.count
        case 2:
            return rejectedRequestList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
//        switch section {
//        case 0:
//            let headerView = TableHeaderView()
//            headerView.configure(title: "درخواست‌های جدید")
//            return headerView
//        case 1:
//            let headerView = TableHeaderView()
//            headerView.configure(title: "درخواست‌های قبول شده")
//            return headerView
//        case 2:
//            let headerView = TableHeaderView()
//            headerView.configure(title: "درخواست‌های رد شده")
//            return headerView
//        default:
//            return UIView()
//        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section <= 2{
            return 55
        } else {
            return 0
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        //        let delta = abs(offsetY)
        let timeInterval: TimeInterval = 3
        if offsetY > 0 {
            if !bigHeaderView.isHidden {
                UIView.animate(withDuration: timeInterval) {
                    self.bigHeaderView.isHidden = true
                    self.smallHeaderView.isHidden = false
                    self.headerViewHeight.constant = 150
                }
            }
        } else if offsetY < -20 {
            if bigHeaderView.isHidden {
                UIView.animate(withDuration: timeInterval) {
                    self.bigHeaderView.isHidden = false
                    self.smallHeaderView.isHidden = true
                    self.headerViewHeight.constant = 300
                }
            }
        }
    }
    
    
}
