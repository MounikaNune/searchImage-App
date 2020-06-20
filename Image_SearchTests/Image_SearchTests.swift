//
//  Image_SearchTests.swift
//  Image_SearchTests
//
//  Created by Admin on 6/20/20.
//  Copyright © 2020 Rehlat. All rights reserved.
//

import XCTest
@testable import Image_Search

class Image_SearchTests: XCTestCase {
    
    var storyBoard: UIStoryboard?
    var imageVC: ImageCollectionViewController?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        storyBoard = UIStoryboard(name: "Main", bundle: nil)
        imageVC = storyBoard?.instantiateViewController(withIdentifier: "ImageCollectionVC") as? ImageCollectionViewController
        imageVC?.loadView()
        imageVC?.viewDidLoad()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testImageCollectionVC() {
        if let vc = imageVC {
            vc.loadView()
            vc.viewDidLoad()
            XCTAssertNotNil(vc, "Storyboard is not connected with a viewcontroller")
            XCTAssertNotNil(vc.imageCollectionView, "collectionview is not connected with a viewcontroller")
            
            
            XCTAssert(vc.conforms(to: UISearchBarDelegate.self), "does not conform to this protocol")
            XCTAssert(vc.conforms(to: UICollectionViewDataSource.self), "does not conform to this protocol")
            XCTAssert(vc.responds(to: #selector(UICollectionViewDataSource.collectionView(_:numberOfItemsInSection:))), "does not respond to this selector")
            XCTAssert(vc.responds(to: #selector(UICollectionViewDataSource.collectionView(_:cellForItemAt:))), "does not respond to this selector")
            XCTAssert(vc.conforms(to: UICollectionViewDelegate.self), "does not conform to this protocol")
            XCTAssert(vc.conforms(to: UICollectionViewDelegateFlowLayout.self), "does not conform to this protocol")
            XCTAssert(vc.responds(to: #selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:sizeForItemAt:))), "does not respond to this selector")
            XCTAssert(vc.responds(to: #selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:minimumLineSpacingForSectionAt:))), "does not respond to this selector")
            XCTAssert(vc.responds(to: #selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:minimumInteritemSpacingForSectionAt:))), "does not respond to this selector")
        }
    }
    
    func testSearchBarDelegates() {
        if let vc = imageVC {
            vc.loadView()
            vc.viewDidLoad()
            XCTAssertNotNil(vc.searchBarItem, "searchBar is not connected with a viewcontroller")
            XCTAssert(vc.responds(to: #selector(UISearchBarDelegate.searchBarCancelButtonClicked(_:))), "does not respond to this selector")
            XCTAssert(vc.responds(to: #selector(UISearchBarDelegate.searchBarSearchButtonClicked(_:))), "does not respond to this selector")
            XCTAssert(vc.responds(to: #selector(UISearchBarDelegate.searchBarShouldBeginEditing(_:))), "does not respond to this selector")
        }
    }
    
    func testImageCell(_ cell: ImageCellCollectionViewCell) {
        XCTAssertNotNil(cell)
        XCTAssertNotNil(cell.itemImageView,"Imageview is not present")
    }
    
    func testFlickrAPICall() {
        let expect = expectation(description: "flickrAPISuccess")
        //        TARequestManager.signIn("mounika.nune@finnair.com").executeIfConnectedInSecureZone()?.validate().responseJSON { (_, _, json, error) in
        //            if error != nil || !TAResponseManager.isValidResponse(json: json) {
        //                let error = Errors.getError(error, json: json)
        //                XCTFail("EmployeeAPICall Failed with error \(error.debugDescription)")
        //                expect.fulfill()
        //            } else {
        //                let employeeObjFromJson = TAResponseManager.employeeDetailsFromJSON(json: json)
        //                expect.fulfill()
        //                XCTAssertNotNil(employeeObjFromJson, "Data is nil in AllEmployeeAPICall")
        //                if let employee = employeeObjFromJson, employee.employeeRole != Employee.Role.undefined {
        //                    Shared.sharedInstance.currentLoggedInEmployee = employee
        //                }
        //            }
        //        }
        let urlString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=06d56a220ad13f7104237d57ace4ec86&format=json&nojsoncallback=1&safe_search=1&text=kittens"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                XCTFail("ImageAPICall Failed with error \(error.localizedDescription)")
                expect.fulfill()
                return
            }
            
            if let data = data {
                expect.fulfill()
                XCTAssertNotNil(data, "Data is nil in AllEmployeeAPICall")
            }
            
        }.resume()
        waitForExpectations(timeout: 40) { (e) in
            if e != nil {
                XCTFail("Expectation Failed with error \(String(describing: e))")
            } else {
                
            }
        }
    }
}
