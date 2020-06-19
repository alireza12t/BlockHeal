//
//  MainViewController.swift
//  BlockHeal
//
//  Created by ali on 6/19/20.
//  Copyright © 2020 Alireza. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "PersonTypeTableViewCell", for: indexPath) as! PersonTypeTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "بیمار"
        case 1:
            cell.titleLabel.text = "پزشک"
        case 2:
            cell.titleLabel.text = "داروخانه"
        default:
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            SegueHelper.pushViewController(sourceViewController: self, destinationViewController: PatientViewController.instantiateFromStoryboardName(storyboardName: .Patient))
        case 1:
            break
//            SegueHelper.pushViewController(sourceViewController: self, destinationViewController: Log.instantiateFromStoryboardName(storyboardName: .Patient))
        case 2:
            SegueHelper.pushViewController(sourceViewController: self, destinationViewController: ViewController.instantiateFromStoryboardName(storyboardName: .Main))

        default:
            break
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = 200 - (scrollView.contentOffset.y + 200)
        var h = imageViewHeight.constant + offsetY
        h = max(150, h)
        h = min(350, h)
        UIView.animate(withDuration: 1) {
            self.imageViewHeight.constant = h
        }
        
    }
    
}
