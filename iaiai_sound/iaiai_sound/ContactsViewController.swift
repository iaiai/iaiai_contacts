//
//  ContactsViewController.swift
//  iaiai_sound
//
//  Created by iaiai on 2018/5/15.
//  Copyright © 2018年 iaiai. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI
import SnapKit

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var contacts:[String:Array<CNContact>]?   //联系人
    var tableView:UITableView?
    var titleArray:Array<String>?
    
    var currentTitle:Array<String>? //最后要显示用的
    var currentContacts:[String:Array<CNContact>]?   //最后要显示用的联系人
    
    private let cellIdentifier:String = "SecondViewControllerCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.title = "联系人"
        
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(ContactsTableViewCell.self,forCellReuseIdentifier: cellIdentifier)
        tableView?.tableFooterView = UIView()
        self.view.addSubview(tableView!)
        tableView?.snp.makeConstraints({ (make) in
            make.top.left.right.bottom.equalTo(self.view)
        })
        
        titleArray = Array<String>()
        titleArray?.append("A")
        titleArray?.append("B")
        titleArray?.append("C")
        titleArray?.append("D")
        titleArray?.append("E")
        titleArray?.append("F")
        titleArray?.append("G")
        titleArray?.append("H")
        titleArray?.append("I")
        titleArray?.append("J")
        titleArray?.append("K")
        titleArray?.append("L")
        titleArray?.append("M")
        titleArray?.append("N")
        titleArray?.append("O")
        titleArray?.append("P")
        titleArray?.append("Q")
        titleArray?.append("R")
        titleArray?.append("S")
        titleArray?.append("T")
        titleArray?.append("U")
        titleArray?.append("V")
        titleArray?.append("W")
        titleArray?.append("X")
        titleArray?.append("Y")
        titleArray?.append("Z")
        
        //初始化联系人
        contacts = [
            "a":[],
            "b":[],
            "c":[],
            "d":[],
            "e":[],
            "f":[],
            "g":[],
            "h":[],
            "i":[],
            "j":[],
            "k":[],
            "l":[],
            "m":[],
            "n":[],
            "o":[],
            "p":[],
            "q":[],
            "r":[],
            "s":[],
            "t":[],
            "u":[],
            "v":[],
            "w":[],
            "x":[],
            "y":[],
            "z":[]
        ]
        
        //申请权限
        let contactStore = CNContactStore()
        if CNContactStore.authorizationStatus(for: .contacts) == CNAuthorizationStatus.notDetermined{
            debugPrint("用户还没有决定是否授权你的程序进行访问")
            contactStore.requestAccess(for: .contacts) { (granted, error) in
                if (error != nil){
                    return
                }
                
                if granted {//允许
                    debugPrint("授权访问通讯录")
                    self.fetchContactWithContactStore(contactStore: contactStore)
                }else{
                    debugPrint("拒绝访问通讯录")
                }
            }
        }else{
            self.fetchContactWithContactStore(contactStore: contactStore)
        }
    }
    
    func fetchContactWithContactStore(contactStore:CNContactStore) {
        let keys = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactNicknameKey,
                    CNContactOrganizationNameKey, CNContactJobTitleKey,
                    CNContactDepartmentNameKey, CNContactNoteKey, CNContactPhoneNumbersKey,
                    CNContactEmailAddressesKey, CNContactPostalAddressesKey,
                    CNContactDatesKey, CNContactInstantMessageAddressesKey
        ]
        
        let fetchRequest = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        
        do {
            try contactStore.enumerateContacts(with: fetchRequest) { (contact, stop) in
                //获取姓名
                let name = "\(contact.familyName)\(contact.givenName)"
                print("姓名：\(name)")
                
                if name.isIncludeChinese(){
                    let pinying = name.transformToPinyin()
                    for title in self.titleArray!{
                        if(pinying.lowercased().starts(with: title.lowercased())){
                            self.contacts?[title.lowercased()]?.append(contact)
                        }
                    }
                }else{
                    for title in self.titleArray!{
                        if(name.lowercased().starts(with: title.lowercased())){
                            self.contacts?[title.lowercased()]?.append(contact)
                        }
                    }
                }
                
                //获取昵称
                let nikeName = contact.nickname
                print("昵称：\(nikeName)")
                
                //获取公司（组织）
                let organization = contact.organizationName
                print("公司（组织）：\(organization)")
                
                //获取职位
                let jobTitle = contact.jobTitle
                print("职位：\(jobTitle)")
                
                //获取部门
                let department = contact.departmentName
                print("部门：\(department)")
                
                //获取备注
                let note = contact.note
                print("备注：\(note)")
                
                //获取电话号码
                print("电话：")
                for phone in contact.phoneNumbers {
                    //获得标签名（转为能看得懂的本地标签名，比如work、home）
                    var label = "未知标签"
                    if phone.label != nil {
                        label = CNLabeledValue<NSString>.localizedString(forLabel: phone.label!)
                    }
                    
                    //获取号码
                    let value = phone.value.stringValue
                    print("\t\(label)：\(value)")
                }
                
                //获取Email
                print("Email：")
                for email in contact.emailAddresses {
                    //获得标签名（转为能看得懂的本地标签名）
                    var label = "未知标签"
                    if email.label != nil {
                        label = CNLabeledValue<NSString>.localizedString(forLabel: email.label!)
                    }
                    
                    //获取值
                    let value = email.value
                    print("\t\(label)：\(value)")
                }
                
                //获取地址
                print("地址：")
                for address in contact.postalAddresses {
                    //获得标签名（转为能看得懂的本地标签名）
                    var label = "未知标签"
                    if address.label != nil {
                        label = CNLabeledValue<NSString>.localizedString(forLabel: address.label!)
                    }
                    
                    //获取值
                    let detail = address.value
                    let contry = detail.value(forKey: CNPostalAddressCountryKey) ?? ""
                    let state = detail.value(forKey: CNPostalAddressStateKey) ?? ""
                    let city = detail.value(forKey: CNPostalAddressCityKey) ?? ""
                    let street = detail.value(forKey: CNPostalAddressStreetKey) ?? ""
                    let code = detail.value(forKey: CNPostalAddressPostalCodeKey) ?? ""
                    let str = "国家:\(contry) 省:\(state) 城市:\(city) 街道:\(street)" + " 邮编:\(code)"
                    print("\t\(label)：\(str)")
                }
                
                //获取纪念日
                print("纪念日：")
                for date in contact.dates {
                    //获得标签名（转为能看得懂的本地标签名）
                    var label = "未知标签"
                    if date.label != nil {
                        label = CNLabeledValue<NSString>.localizedString(forLabel:date.label!)
                    }
                    
                    //获取值
                    let dateComponents = date.value as DateComponents
                    let value = NSCalendar.current.date(from: dateComponents)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
                    print("\t\(label)：\(dateFormatter.string(from: value!))")
                }
                
                //获取即时通讯(IM)
                print("即时通讯(IM)：")
                for im in contact.instantMessageAddresses {
                    //获得标签名（转为能看得懂的本地标签名）
                    var label = "未知标签"
                    if im.label != nil {
                        label = CNLabeledValue<NSString>.localizedString(forLabel:im.label!)
                    }
                    
                    //获取值
                    let detail = im.value
                    let username = detail.value(forKey: CNInstantMessageAddressUsernameKey) ?? ""
                    let service = detail.value(forKey: CNInstantMessageAddressServiceKey) ?? ""
                    print("\t\(label)：\(username) 服务:\(service)")
                }
                
                print("----------------")
            }
        }catch{
            debugPrint("\(error)")
        }
        
        currentTitle = Array<String>()
        currentContacts = [:]
        for title in titleArray!{
            if (contacts![title.lowercased()]?.count)! > 0{
                currentTitle?.append(title)
                currentContacts![title.lowercased()] = contacts![title.lowercased()]
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (currentContacts?[(currentTitle?[section].lowercased())!]!.count)!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (currentContacts != nil) ? (currentContacts?.count)! : 0
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return currentTitle
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleView = UIView()
        titleView.backgroundColor = ColorUtil.colorWithHexString(color: "#efeff4")
        titleView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 20)
        
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 20, y: 0, width: 60, height: 20)
        titleLabel.text = currentTitle?[section]
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleView.addSubview(titleLabel)
        
        return titleView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ContactsTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ContactsTableViewCell
        
        //右箭头
        cell?.accessoryType = .disclosureIndicator
        
        let contact = currentContacts?[(currentTitle?[indexPath.section].lowercased())!]![indexPath.row]
        
        //姓名
        var name = ""
        if ((contact?.familyName) != nil){
            name.append((contact?.familyName)!)
        }
        if ((contact?.givenName) != nil){
            name.append((contact?.givenName)!)
        }
        cell?.textLabel?.text = name
        
        //获取电话号码
        var tel = ""
        for phone in (contact?.phoneNumbers)! {
            //获取号码
            if tel.count > 0{
                tel = tel + " / "
            }
            tel = tel + phone.value.stringValue
        }
        cell?.detailTextLabel?.text = tel
        cell?.detailTextLabel?.textColor = UIColor.black
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 11)
        
        cell?.imageView?.image = UIImage(named: "contacts")
        
        return cell!
    }
    
    //去除点击的阴影
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        let controller = ContactViewController()
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "contact") as! ContactViewController
        controller.contact = currentContacts?[(currentTitle?[indexPath.section].lowercased())!]![indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension String {
    func isIncludeChinese() -> Bool {
        for ch in self.unicodeScalars {
            // 中文字符范围：0x4e00 ~ 0x9fff
            if (0x4e00 < ch.value  && ch.value < 0x9fff) {
                return true
            }
        }
        return false
    }
    
    func transformToPinyin() -> String {
        let stringRef = NSMutableString(string: self) as CFMutableString
        // 转换为带音标的拼音
        CFStringTransform(stringRef,nil, kCFStringTransformToLatin, false);
        // 去掉音标
        CFStringTransform(stringRef, nil, kCFStringTransformStripCombiningMarks, false);
        let pinyin = stringRef as String;
        
        return pinyin
    }
}

