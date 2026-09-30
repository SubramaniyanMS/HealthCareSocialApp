//
//  Pagination.swift
//  HealthcareSocialApp
//
//  Created by Apple on 29/09/26.
//
import Foundation

// MARK: - Request

struct PaginatorRequest: Codable {
    let pageSize: Int
    let pageNumber: Int
    let totalPages: Int
    let nextPage: Int       // Page to fetch
    let previousPage: Int
}

// MARK: - Response

struct Paginator: Codable {
    let pageSize: Int?
    let pageNumber: Int?
    let totalPages: Int?
    let nextPage: Int?
    let previousPage: Int?
}

// MARK: - Request body

struct PostRequest: Codable {
    let paginator: PaginatorRequest
    let postCategoryType: Int
    let postType: Int
    let tagId: String
    let coordinates: [Double]
    let enableUserTagBasedFilter: Int
}
