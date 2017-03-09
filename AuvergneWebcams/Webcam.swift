//
//  Webcam.swift
//  AuvergneWebcams
//
//  Created by Drusy on 09/11/2016.
//
//

import Foundation
import ObjectMapper
import SwiftyUserDefaults
import RealmSwift

class Webcam: Object, Mappable {
    
    #if DEBUG
        static let refreshInterval: TimeInterval = 60 * 1
    #else
        static let refreshInterval: TimeInterval = 60 * 10
    #endif
    
    static let retryCount: Int = 3
    
    // Update from WS
    dynamic var uid: Int = 0
    dynamic var order: Int = 0
    dynamic var title: String?
    dynamic var imageHD: String?
    dynamic var imageLD: String?
    dynamic var video: String?
    dynamic var lowQualityOnly: Bool = false
    
    // Interval data
    dynamic var lastUpdate: Date?

    var tags = List<WebcamTag>()
    
    // MARK: -
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        var tagsArray = [String]()
        
        uid <- map["uid"]
        order <- map["order"]
        title <- map["title"]
        imageHD <- map["imageHD"]
        imageLD <- map["imageLD"]
        video <- map["video"]
        lowQualityOnly <- map["lowQualityOnly"]
        
        tagsArray <- map["tags"]
        setTags(from: tagsArray)
        
        let realm = try? Realm()
        if let webcam = realm?.object(ofType: Webcam.self, forPrimaryKey: uid) {
            lastUpdate = webcam.lastUpdate
        }
    }
    
    override static func primaryKey() -> String? {
        return #keyPath(Webcam.uid)
    }
    
    // MARK: -
    
    func setTags(from arrayString: [String]) {
        for tag in arrayString {
            let webcamTag = WebcamTag()
            webcamTag.tag = tag
            tags.append(webcamTag)
        }
    }
    
    func preferredImage() -> String? {
        if Defaults[.prefersHighQuality] {
            return imageHD ?? imageLD
        } else {
            return imageLD ?? imageHD
        }
    }
}
