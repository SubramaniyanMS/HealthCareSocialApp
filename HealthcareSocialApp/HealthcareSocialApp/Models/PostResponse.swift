//
//  PostResponse.swift
//  HealthcareSocialApp
//
//  Created by Apple on 29/09/26.
//

import Foundation

// MARK: - Response

struct HealthData: Codable {
    let isOk: Bool?
    let data: FeedData?
}

// MARK: - Data

struct FeedData: Codable {
    let feeds: [Feed]?
    let lastPostCreatedDate: Int?
    let currentUsername: String?
    let currentProfilePic: String?
    let currentUserGender: Int?
    let nft: Int?
    let commentCount: Int?
    let rating: Int?
    let ratedUserCount: Int?
    let paginator: Paginator?
}

// MARK: - Feed Post

struct Feed: Codable, Identifiable {
    let allowAnonymous: Bool?
    let postContent: String?
    let viewCount: Int?
    let threadCount: Int?
    let clapCount: Int?
    let createdDate: Int?
    let coordinates: [Double]?
    let mediaURL: String?
    let mediaType: Int?
    let postType: Int?
    let postID: String?
    let thumbNail: String?
    let profileName: String?
    let gender: Int?
    let tagName: String?
    let profilePic: String?
    let bgColor: String?
    let textColor: String?
    let tagID: String?
    let userID: String?
    let nft: Int?
    let monetize: Int?
    let monetizeAmount: Int?
    let monetizeActualAmount: Int?
    let monetizePlatformAmount: Int?
    let monetizeTax: Int?
    let currencyCode: String?
    let currencySymbol: String?
    let score: Int?
    let rating: Int?
    let commentCount: Int?
    let ratedUserCount: Int?
    let threadID: String?
    let threadLimit: Int?
    let isView: Bool?
    let isClap: Bool?

    var id: String { postID ?? UUID().uuidString }

    enum CodingKeys: String, CodingKey {
        case allowAnonymous, postContent, viewCount, threadCount, clapCount
        case createdDate, coordinates
        case mediaURL = "mediaUrl"
        case mediaType, postType
        case postID = "postId"
        case thumbNail, profileName, gender, tagName, profilePic, bgColor, textColor
        case tagID = "tagId"
        case userID = "userId"
        case nft, monetize, monetizeAmount, monetizeActualAmount
        case monetizePlatformAmount, monetizeTax, currencyCode, currencySymbol
        case score, rating, commentCount, ratedUserCount
        case threadID = "threadId"
        case threadLimit, isView, isClap
    }


    var fullMediaURL: URL? {
        APIClient.fullMediaURL(from: mediaURL)
    }

    var fullProfilePicURL: URL? {
        APIClient.fullProfilePicURL(from: profilePic)
    }

    var displayDate: String {
        createdDate?.formattedDate ?? ""
    }

    var hasMedia: Bool {
        !(mediaURL ?? "").isEmpty
    }
}
