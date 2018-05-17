//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by Valentinas Mirosnicenko on 12/23/16.
//  Copyright © 2016 Valentinas Mirosnicenko. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UINavigationControllerDelegate {
    
    // Outlets
    @IBOutlet private weak var itemNameTextField: CustomTextField!
    @IBOutlet private weak var itemPriceTextField: CustomTextField!
    @IBOutlet private weak var itemDetailsTextField: CustomTextField!
    @IBOutlet private weak var storePicker: UIPickerView!
    @IBOutlet private weak var typePicker: UIPickerView!
    @IBOutlet private weak var thumbImage: UIImageView!
    @IBOutlet private weak var saveStoreButton: UIButton!
    
    // Variables
    private var stores = [Store]()
    private var types = [ItemType]()
    var itemToEdit: Item?
    private var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        itemNameTextField.delegate = self
        itemPriceTextField.delegate = self
        itemDetailsTextField.delegate = self
        
        storePicker.dataSource = self
        storePicker.delegate = self
        typePicker.delegate = self
        typePicker.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        getData()
        
        if itemToEdit != nil {
            loadItemData()
        }
        
//        if storePicker.numberOfRows(inComponent: 0) == 0 {
//            saveStoreButton.isHidden = true
//            loadTestData.isHidden = false
//            storePicker.isHidden = true
//            typePicker.isHidden = true
//        } else {
//            saveStoreButton.isHidden = false
//            loadTestData.isHidden = true
//        }
    }
    
    // Controller Actions
//    @IBAction func loadTestDataButtonPressed(_ sender: Any) {
//        if stores.count == 0 {
//            getTestData()
//            getData()
//            storePicker.reloadAllComponents()
//            typePicker.reloadAllComponents()
//            loadTestData.isHidden = true
//            storePicker.isHidden = false
//            typePicker.isHidden = false
//            saveStoreButton.isHidden = false
//        }
//    }
    
    @IBAction func saveItemButtonPressed(_ sender: Any) {
        
        var item: Item!
        
        let picture = Image(context: context)

        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
        picture.image = thumbImage.image
        item.toImage = picture

        if let title = itemNameTextField.text {
            item.title = title
        }
        
        if let price = itemPriceTextField.text {
            item.price = (price as NSString).doubleValue
        }
        
        if let details = itemDetailsTextField.text {
            item.details = details
        }

        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        item.toItemType = types[typePicker.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)

    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
            
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func addImageButtonPressed(_ sender: UIButton) {
        present(imagePicker, animated: false, completion: nil)
    }
    
    // Controller Methods
    func loadItemData() {
        
        if let item = itemToEdit {
            
            itemNameTextField.text = item.title
            itemPriceTextField.text = "\(item.price)"
            itemDetailsTextField.text = item.details
            thumbImage.image = item.toImage?.image as? UIImage

            if let store = item.toStore {
                
                var storeIndex = 0
                repeat {
                    let s = stores[storeIndex]
                    if s.name == store.name {
                        storePicker.selectRow(storeIndex, inComponent: 0, animated: false)
                        break
                        
                    }
                    storeIndex += 1
                    
                } while (storeIndex < stores.count)
            }
            if let type = item.toItemType {
                var typeIndex = 0
                repeat {
                    let t = types[typeIndex]
                    if t.type == type.type {
                        typePicker.selectRow(typeIndex, inComponent: 0, animated: false)
                        break
                    }
                    typeIndex += 1
                } while (typeIndex < types.count)
            }
        }
    }
    
    func getData() {
        
        let storeFetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        let typeFetchRequest: NSFetchRequest<ItemType> = ItemType.fetchRequest()
        
        do {
            self.stores = try context.fetch(storeFetchRequest)
            self.types = try context.fetch(typeFetchRequest)
            //storePicker.reloadAllComponents()
            //typePicker.reloadAllComponents()
        } catch {
            //Error handling code
        }
    }
    
}

extension ItemDetailsVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ItemDetailsVC: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumbImage.image = img
        }
        imagePicker.dismiss(animated: false, completion: nil)
    }
    
}

extension ItemDetailsVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {        let store = stores[row]
        let type = types[row]
        
        if pickerView.tag == 0 {
            return store.name
        } else if pickerView.tag == 1 {
            return type.type
        } else {
            return "Empty Data"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return stores.count
        } else if pickerView.tag == 1 {
            return types.count
        } else {
            return 0
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //update when selected
    }
}
