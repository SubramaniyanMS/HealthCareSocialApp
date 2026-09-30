import Foundation

// MARK: - Mock Service

final class MockPostService: PostServiceProtocol {

    func fetchPosts(nextPage: Int, bearerToken: String) async throws -> FeedData {
        let json: String
        switch nextPage {
        case 1:  json = Self.page1
        case 2:  json = Self.page2
        case 3:  json = Self.page3
        default:
            return FeedData(
                feeds: [],
                lastPostCreatedDate: nil,
                currentUsername: nil,
                currentProfilePic: nil,
                currentUserGender: nil,
                nft: nil,
                commentCount: nil,
                rating: nil,
                ratedUserCount: nil,
                paginator: Paginator(
                    pageSize: 20,
                    pageNumber: nextPage,
                    totalPages: 3,
                    nextPage: 0,
                    previousPage: nextPage - 1
                )
            )
        }
        let data = Data(json.utf8)
        let decoded = try JSONDecoder().decode(HealthData.self, from: data)
        guard let feedData = decoded.data else { throw APIError.noData }
        return feedData
    }

    // MARK: - Page 1 (nextPage = 1)

    private static let page1 = """
    {
      "isOk": true,
      "data": {
        "currentUsername": "Mathew Joseph",
        "currentProfilePic": "64c2036cd8811405dde0e0a3/IMG_20260619_173612868.jpg",
        "currentUserGender": 2,
        "nft": 1,
        "paginator": { "pageSize": 20, "pageNumber": 2, "totalPages": 2, "nextPage": 2, "previousPage": 0 },
        "feeds": [
          {
            "allowAnonymous": false, "postContent": "Ixtixiyxyi",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1787223418, "coordinates": [0, 0],
            "mediaUrl": "", "mediaType": 1, "postType": 3,
            "postId": "6a86dd7a39abab7e405af615", "thumbNail": "",
            "profileName": "Payment Format Business", "gender": 0,
            "tagName": "bottom four",
            "profilePic": "64c2036cd8811405dde0e0a3/IMG_20260613_232205580.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "6a5db0000000000000000001", "userId": "64c2036cd8811405dde0e0a3"
          },
          {
            "allowAnonymous": false, "postContent": "Dtxixitciy",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1787223370, "coordinates": [0, 0],
            "mediaUrl": "", "mediaType": 1, "postType": 3,
            "postId": "6a86dd4a39abab7e405af59c", "thumbNail": "",
            "profileName": "Payment Format Business", "gender": 0,
            "tagName": "bloatware",
            "profilePic": "64c2036cd8811405dde0e0a3/IMG_20260613_232205580.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "6a5db0000000000000000002", "userId": "64c2036cd8811405dde0e0a3"
          },
          {
            "allowAnonymous": false, "postContent": "Fohcc",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1787223331, "coordinates": [0, 0],
            "mediaUrl": "", "mediaType": 1, "postType": 3,
            "postId": "6a86dd2339abab7e405af535", "thumbNail": "",
            "profileName": "Payment Format Business", "gender": 0,
            "tagName": "Budgeting & financial planning",
            "profilePic": "64c2036cd8811405dde0e0a3/IMG_20260613_232205580.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "649d80d1640c752af9ec09f8", "userId": "64c2036cd8811405dde0e0a3"
          },
          {
            "allowAnonymous": false, "postContent": "Hi",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1787223296, "coordinates": [0, 0],
            "mediaUrl": "", "mediaType": 1, "postType": 3,
            "postId": "6a86dd0039abab7e405af4f6", "thumbNail": "",
            "profileName": "Payment Format Business", "gender": 0,
            "tagName": "Application Testing",
            "profilePic": "64c2036cd8811405dde0e0a3/IMG_20260613_232205580.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "6a574553f2a6e9eb2a169553", "userId": "64c2036cd8811405dde0e0a3"
          },
          {
            "allowAnonymous": false, "postContent": "The first thing that",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784826226, "coordinates": [0, 0],
            "mediaUrl": "6a575b26f2a6e9eb2a170026/8E685A79-7379-4D76-8296-A3499260ECE6_1784826222.png",
            "mediaType": 2, "postType": 3,
            "postId": "6a62497239abab7e404f553e", "thumbNail": "",
            "profileName": "Check Payment History", "gender": 0,
            "tagName": "Anime",
            "profilePic": "6a575958f2a6e9eb2a16eef6/IMG_20260715_153248468.jpg",
            "bgColor": "", "textColor": "",
            "tagId": "6a575b26f2a6e9eb2a170000", "userId": "6a575b26f2a6e9eb2a170026"
          },
          {
            "allowAnonymous": false, "postContent": "Gwhwhehw",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784826207, "coordinates": [0, 0],
            "mediaUrl": "", "mediaType": 1, "postType": 3,
            "postId": "6a62495f39abab7e404f5503", "thumbNail": "",
            "profileName": "Check Payment History", "gender": 0,
            "tagName": "Animals",
            "profilePic": "6a575958f2a6e9eb2a16eef6/IMG_20260715_153248468.jpg",
            "bgColor": "#06623B", "textColor": "#ffffff",
            "tagId": "6a575958f2a6e9eb2a16ef00", "userId": "6a575958f2a6e9eb2a16eef6"
          },
          {
            "allowAnonymous": false, "postContent": "Ball",
            "viewCount": 12, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784725300, "coordinates": [0, 0],
            "mediaUrl": "6a5cbceb398eadcbfc51a12a/1784725297.jpg",
            "mediaType": 2, "postType": 3,
            "postId": "6a60bf34a9eedd72e945d4b3", "thumbNail": "",
            "profileName": "Franchise One", "gender": 0,
            "tagName": "Entertainment",
            "profilePic": "6a5cb7c7398eadcbfc5182c8/IMG_20260719_173149100.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "6a5cb7c7398eadcbfc518300", "userId": "6a5cbceb398eadcbfc51a12a"
          },
          {
            "allowAnonymous": false, "postContent": "Ball",
            "viewCount": 2, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784725193, "coordinates": [0, 0],
            "mediaUrl": "6a5cbdd2398eadcbfc51a49a/1784725190.jpg",
            "mediaType": 2, "postType": 3,
            "postId": "6a60bec9a9eedd72e945cf93", "thumbNail": "",
            "profileName": "Franchise Group", "gender": 0,
            "tagName": "Entertainment",
            "profilePic": "66c46c1b5f7211f671b539af/IMG_20260719_173416945.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "66c46c1b5f7211f671b53900", "userId": "6a5cbdd2398eadcbfc51a49a"
          },
          {
            "allowAnonymous": false, "postContent": "Dinner kore",
            "viewCount": 3, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784544236, "coordinates": [0, 0],
            "mediaUrl": "6a5dfad4c6f718786b1bde1c/1784544232.jpg",
            "mediaType": 2, "postType": 3,
            "postId": "6a5dfbecc6f718786b1be746", "thumbNail": "",
            "profileName": "Joey's Burger", "gender": 0,
            "tagName": "food",
            "profilePic": "6a5dfad4c6f718786b1bde1c/IMG_20260720_185406044.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "674a1000000000000000000", "userId": "6a5dfad4c6f718786b1bde1c"
          },
          {
            "allowAnonymous": false, "postContent": "Mirchi bachi",
            "viewCount": 1, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784544214, "coordinates": [0, 0],
            "mediaUrl": "6a5dfad4c6f718786b1bde1c/1784544210.jpg",
            "mediaType": 2, "postType": 3,
            "postId": "6a5dfbd6c6f718786b1be655", "thumbNail": "",
            "profileName": "Joey's Burger", "gender": 0,
            "tagName": "street food",
            "profilePic": "6a5dfad4c6f718786b1bde1c/IMG_20260720_185406044.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "6a5dfbd6c6f718786b1be600", "userId": "6a5dfad4c6f718786b1bde1c"
          },
          {
            "allowAnonymous": false, "postContent": "Get good bihari food here",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784544095, "coordinates": [0, 0],
            "mediaUrl": "", "mediaType": 1, "postType": 3,
            "postId": "6a5dfb5fc6f718786b1be28f", "thumbNail": "",
            "profileName": "Joey's Burger", "gender": 0,
            "tagName": "food safety",
            "profilePic": "6a5dfad4c6f718786b1bde1c/IMG_20260720_185406044.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "674a1000000000000000001", "userId": "6a5dfad4c6f718786b1bde1c"
          },
          {
            "allowAnonymous": false, "postContent": "Good Evening",
            "viewCount": 2, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784461931, "coordinates": [0, 0],
            "mediaUrl": "", "mediaType": 1, "postType": 3,
            "postId": "6a5cba6b398eadcbfc5191e2", "thumbNail": "",
            "profileName": "Nivia Business Model", "gender": 0,
            "tagName": "Entertainment",
            "profilePic": "66c46c1b5f7211f671b539af/IMG_20260719_170738527.jpg",
            "bgColor": "#0A0A2E", "textColor": "#ffffff",
            "tagId": "66c46c1b5f7211f671b53901", "userId": "66c46c1b5f7211f671b539af"
          },
          {
            "allowAnonymous": false, "postContent": "Hello",
            "viewCount": 5, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784300930, "coordinates": [0, 0],
            "mediaUrl": "", "mediaType": 1, "postType": 3,
            "postId": "6a5a45824cbc3a64dacf81eb", "thumbNail": "",
            "profileName": "Pizza Hut", "gender": 0,
            "tagName": "Affiliate marketing",
            "profilePic": "6a25ba6941dbaf9c3daa98ed/IMG_20260710_210626865.jpg",
            "bgColor": "#381460", "textColor": "#ffffff",
            "tagId": "649d80d1640c752af9ec0a00", "userId": "6a25ba6941dbaf9c3daa98ed"
          },
          {
            "allowAnonymous": false, "postContent": "4rditu",
            "viewCount": 2, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784293595, "coordinates": [0, 0],
            "mediaUrl": "", "mediaType": 1, "postType": 3,
            "postId": "6a5a28dbc2c592ab3ca5c870", "thumbNail": "",
            "profileName": "Test Biz", "gender": 0,
            "tagName": "Application Testing",
            "profilePic": "6a59e3d781aa23885d84b246/IMG_20260717_170853940.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "6a574553f2a6e9eb2a169553", "userId": "6a59e3d781aa23885d84b246"
          },
          {
            "allowAnonymous": false, "postContent": "Test",
            "viewCount": 1, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784293074, "coordinates": [0, 0],
            "mediaUrl": "6a5a148e7b8bd9b898c85de2/1784293071.jpg",
            "mediaType": 2, "postType": 3,
            "postId": "6a5a26d2c2c592ab3ca5bb59", "thumbNail": "",
            "profileName": "Test Biz", "gender": 0,
            "tagName": "Business ethics",
            "profilePic": "6a59e3d781aa23885d84b246/IMG_20260717_170853940.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "649d80d1640c752af9ec0a16", "userId": "6a59e3d781aa23885d84b246"
          },
          {
            "allowAnonymous": false, "postContent": "Tarun",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784293047, "coordinates": [0, 0],
            "mediaUrl": "", "mediaType": 1, "postType": 3,
            "postId": "6a5a26b7c2c592ab3ca5ba8a", "thumbNail": "",
            "profileName": "Test Biz", "gender": 0,
            "tagName": "Agile methodologies",
            "profilePic": "6a59e3d781aa23885d84b246/IMG_20260717_170853940.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "649d80d1640c752af9ec09f5", "userId": "6a59e3d781aa23885d84b246"
          },
          {
            "allowAnonymous": false, "postContent": "Test",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784287428, "coordinates": [0, 0],
            "mediaUrl": "6a5a0eed7b8bd9b898c844e2/EBB80646-D1C1-4084-88E8-34BDD17E7ADD_1784287426.m4a",
            "mediaType": 4, "postType": 3,
            "postId": "6a5a10c47b8bd9b898c84d4a", "thumbNail": "",
            "profileName": "Vasu pet store", "gender": 0,
            "tagName": "apple juice",
            "profilePic": "6a59e51381aa23885d84bc73/C05A7EBE-7B10-4FD0-BB2A-FB1BB1B8802A_1784286703.png",
            "bgColor": "", "textColor": "",
            "tagId": "6a56022e1019368a0e9b0706", "userId": "6a5a0eed7b8bd9b898c844e2"
          },
          {
            "allowAnonymous": false, "postContent": "Test post",
            "viewCount": 1, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784287399, "coordinates": [0, 0],
            "mediaUrl": "https://wavedinblobs.blob.core.windows.net/wavedinblobs/Videos/6a5a0eed7b8bd9b898c844e2/1784287396794/master.m3u8",
            "mediaType": 3, "postType": 3,
            "postId": "6a5a10b47b8bd9b898c84d00", "thumbNail": "",
            "profileName": "Vasu pet store", "gender": 0,
            "tagName": "Corporate finance",
            "profilePic": "6a59e51381aa23885d84bc73/C05A7EBE-7B10-4FD0-BB2A-FB1BB1B8802A_1784286703.png",
            "bgColor": "", "textColor": "",
            "tagId": "649d80d1640c752af9ec0a37", "userId": "6a5a0eed7b8bd9b898c844e2"
          },
          {
            "allowAnonymous": false, "postContent": "Test",
            "viewCount": 3, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784287333, "coordinates": [0, 0],
            "mediaUrl": "https://wavedinblobs.blob.core.windows.net/wavedinblobs/Videos/6a5a0eed7b8bd9b898c844e2/1784287330486/master.m3u8",
            "mediaType": 3, "postType": 3,
            "postId": "6a5a10b47b8bd9b898c84d01", "thumbNail": "",
            "profileName": "Vasu pet store", "gender": 0,
            "tagName": "Budgeting & financial planning",
            "profilePic": "6a59e51381aa23885d84bc73/C05A7EBE-7B10-4FD0-BB2A-FB1BB1B8802A_1784286703.png",
            "bgColor": "", "textColor": "",
            "tagId": "649d80d1640c752af9ec09f8", "userId": "6a5a0eed7b8bd9b898c844e2"
          },
          {
            "allowAnonymous": false, "postContent": "Tattoo",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784287261, "coordinates": [0, 0],
            "mediaUrl": "6a5a0eed7b8bd9b898c844e2/85F1CF2D-11BF-4641-AF7E-008E0DC3B42A_1784287258.png",
            "mediaType": 2, "postType": 3,
            "postId": "6a5a101d7b8bd9b898c84ad1", "thumbNail": "",
            "profileName": "Vasu pet store", "gender": 0,
            "tagName": "Business ethics",
            "profilePic": "6a59e51381aa23885d84bc73/C05A7EBE-7B10-4FD0-BB2A-FB1BB1B8802A_1784286703.png",
            "bgColor": "", "textColor": "",
            "tagId": "649d80d1640c752af9ec0a16", "userId": "6a5a0eed7b8bd9b898c844e2"
          }
        ]
      }
    }
    """

    // MARK: - Page 2 (nextPage = 2)

    private static let page2 = """
    {
      "isOk": true,
      "data": {
        "currentUsername": "Mathew Joseph",
        "currentProfilePic": "64c2036cd8811405dde0e0a3/IMG_20260619_173612868.jpg",
        "currentUserGender": 2,
        "nft": 1,
        "paginator": { "pageSize": 20, "pageNumber": 3, "totalPages": 3, "nextPage": 3, "previousPage": 1 },
        "feeds": [
          {
            "allowAnonymous": false, "postContent": "Tattoo",
            "viewCount": 1, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784287260, "coordinates": [0, 0],
            "mediaUrl": "6a5a0eed7b8bd9b898c844e2/DF012825-1F15-44DD-9E97-76D76BF94A2B_1784287257.png",
            "mediaType": 2, "postType": 3,
            "postId": "6a5a101c7b8bd9b898c84aad", "thumbNail": "",
            "profileName": "Vasu pet store", "gender": 0,
            "tagName": "Business ethics",
            "profilePic": "6a59e51381aa23885d84bc73/C05A7EBE-7B10-4FD0-BB2A-FB1BB1B8802A_1784286703.png",
            "bgColor": "", "textColor": "",
            "tagId": "649d80d1640c752af9ec0a16", "userId": "6a5a0eed7b8bd9b898c844e2"
          },
          {
            "allowAnonymous": false, "postContent": "Test",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784287208, "coordinates": [0, 0],
            "mediaUrl": "6a5a0eed7b8bd9b898c844e2/E6E87643-DC08-4D7F-B5FD-02433B6C0751_1784287204.png",
            "mediaType": 2, "postType": 3,
            "postId": "6a5a0fe87b8bd9b898c849e9", "thumbNail": "",
            "profileName": "Vasu pet store", "gender": 0,
            "tagName": "books",
            "profilePic": "6a59e51381aa23885d84bc73/C05A7EBE-7B10-4FD0-BB2A-FB1BB1B8802A_1784286703.png",
            "bgColor": "", "textColor": "",
            "tagId": "6a547ca2120606170b78d1b5", "userId": "6a5a0eed7b8bd9b898c844e2"
          },
          {
            "allowAnonymous": false, "postContent": "Hi, you can buy pets from this place",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784287154, "coordinates": [0, 0],
            "mediaUrl": "", "mediaType": 1, "postType": 3,
            "postId": "6a5a0fb27b8bd9b898c848d9", "thumbNail": "",
            "profileName": "Vasu pet store", "gender": 0,
            "tagName": "Business ethics",
            "profilePic": "6a59e51381aa23885d84bc73/C05A7EBE-7B10-4FD0-BB2A-FB1BB1B8802A_1784286703.png",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "649d80d1640c752af9ec0a16", "userId": "6a5a0eed7b8bd9b898c844e2"
          },
          {
            "allowAnonymous": false, "postContent": "Hi, you can buy pets from this place",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784287153, "coordinates": [0, 0],
            "mediaUrl": "", "mediaType": 1, "postType": 3,
            "postId": "6a5a0fb17b8bd9b898c848ab", "thumbNail": "",
            "profileName": "Vasu pet store", "gender": 0,
            "tagName": "Business ethics",
            "profilePic": "6a59e51381aa23885d84bc73/C05A7EBE-7B10-4FD0-BB2A-FB1BB1B8802A_1784286703.png",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "649d80d1640c752af9ec0a16", "userId": "6a5a0eed7b8bd9b898c844e2"
          },
          {
            "allowAnonymous": false, "postContent": "Gx I hope he has an",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784287062, "coordinates": [0, 0],
            "mediaUrl": "6a58d22d294b79b6b61838f6/DBC30B47-3C69-4486-8CE2-6E6313C39CED_1784287058.png",
            "mediaType": 2, "postType": 3,
            "postId": "6a5a0f567b8bd9b898c846f6", "thumbNail": "",
            "profileName": "Dpudoy", "gender": 0,
            "tagName": "Agile methodologies",
            "profilePic": "6a58d22d294b79b6b61838f6/6BD3A697-246B-4E35-B555-76AD63F26774_1784205829.png",
            "bgColor": "", "textColor": "",
            "tagId": "67256a6c46121921fc24e1f9", "userId": "6a58d22d294b79b6b61838f6"
          },
          {
            "allowAnonymous": false, "postContent": "Hello",
            "viewCount": 1, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784285636, "coordinates": [0, 0],
            "mediaUrl": "", "mediaType": 1, "postType": 3,
            "postId": "6a5a09c47b8bd9b898c82ef2", "thumbNail": "",
            "profileName": "Dpudoy", "gender": 0,
            "tagName": "Agile methodologies",
            "profilePic": "6a59000f6f387b2d328dd685/IMG_20260716_120732746.jpg",
            "bgColor": "#142850", "textColor": "#ffffff",
            "tagId": "649d80d1640c752af9ec09f5", "userId": "6a59000f6f387b2d328dd685"
          },
          {
            "allowAnonymous": false, "postContent": "The only way I",
            "viewCount": 2, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784285534, "coordinates": [0, 0],
            "mediaUrl": "https://wavedinblobs.blob.core.windows.net/wavedinblobs/Videos/6a5901216f387b2d328de0b5/1784285531338/master.m3u8",
            "mediaType": 3, "postType": 3,
            "postId": "6a5a091c7b8bd9b898c82d00", "thumbNail": "",
            "profileName": "iOS franchise", "gender": 0,
            "tagName": "Affiliate marketing",
            "profilePic": "6a58f6df6f387b2d328d913f/C451BEEB-9947-42A9-9880-323F7AA77015_1784217830.png",
            "bgColor": "", "textColor": "",
            "tagId": "649d80d1640c752af9ec0a40", "userId": "6a5901216f387b2d328de0b5"
          },
          {
            "allowAnonymous": false, "postContent": "Hi",
            "viewCount": 1, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784284343, "coordinates": [0, 0],
            "mediaUrl": "", "mediaType": 1, "postType": 3,
            "postId": "6a5a04b781aa23885d852080", "thumbNail": "",
            "profileName": "iOS franchise", "gender": 0,
            "tagName": "AI & ML",
            "profilePic": "6a58f6df6f387b2d328d913f/FAF37A3D-3147-4F7F-8FC4-B21D2C3149CB_1784217733.png",
            "bgColor": "#B21F66", "textColor": "#ffffff",
            "tagId": "649d80d1640c752af9ec0a11", "userId": "6a5901216f387b2d328de0b5"
          },
          {
            "allowAnonymous": false, "postContent": "Hdhdhddhdhxhdh",
            "viewCount": 2, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784212870, "coordinates": [0, 0],
            "mediaUrl": "", "mediaType": 1, "postType": 3,
            "postId": "6a58ed864e6e93cb38f6b45f", "thumbNail": "",
            "profileName": "Duhdhddhjfhchc", "gender": 0,
            "tagName": "Agile methodologies",
            "profilePic": "6a5890874e4cc7177233b51f/6BD3A697-246B-4E35-B555-76AD63F26774_1784205829.png",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "69711974709d9b20cb8d255a", "userId": "6a58d22d294b79b6b61838f6"
          },
          {
            "allowAnonymous": false, "postContent": "Dcjvmnc",
            "viewCount": 1, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784211266, "coordinates": [0, 0],
            "mediaUrl": "", "mediaType": 1, "postType": 3,
            "postId": "6a58e7420136f0695c6954bc", "thumbNail": "",
            "profileName": "Duhdhddhjfhchc", "gender": 0,
            "tagName": "Agile methodologies",
            "profilePic": "6a5890874e4cc7177233b51f/6BD3A697-246B-4E35-B555-76AD63F26774_1784205829.png",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "67256a6c46121921fc24e1f9", "userId": "6a58d22d294b79b6b61838f6"
          },
          {
            "allowAnonymous": false, "postContent": "Djhdhddhhdhd",
            "viewCount": 3, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784211039, "coordinates": [0, 0],
            "mediaUrl": "", "mediaType": 1, "postType": 3,
            "postId": "6a58e65f0136f0695c694c50", "thumbNail": "",
            "profileName": "Duhdhddhjfhchc", "gender": 0,
            "tagName": "Application Testing",
            "profilePic": "6a5890874e4cc7177233b51f/6BD3A697-246B-4E35-B555-76AD63F26774_1784205829.png",
            "bgColor": "#06623B", "textColor": "#ffffff",
            "tagId": "6a574553f2a6e9eb2a169553", "userId": "6a58d22d294b79b6b61838f6"
          },
          {
            "allowAnonymous": false, "postContent": "Interior design",
            "viewCount": 2, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784140741, "coordinates": [0, 0],
            "mediaUrl": "6a574697f2a6e9eb2a169c73/15F4A2D4-CEC2-4FA8-AD60-94819A3554AC_1784140738.png",
            "mediaType": 2, "postType": 3,
            "postId": "6a57d3c5e38ecdc80baee615", "thumbNail": "",
            "profileName": "R Pvt Ltd", "gender": 0,
            "tagName": "interior decorating",
            "profilePic": "6a5743fbf2a6e9eb2a168d6e/40331223-EE9A-4E72-A4E3-5E63AED6A7FE_1784104407.png",
            "bgColor": "", "textColor": "",
            "tagId": "6889611c709d9b20cb7db4c9", "userId": "6a574697f2a6e9eb2a169c73"
          },
          {
            "allowAnonymous": false, "postContent": "Hiiiiii",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784067305, "coordinates": [0, 0],
            "mediaUrl": "", "mediaType": 1, "postType": 3,
            "postId": "6a56b4e9f2a6e9eb2a15907e", "thumbNail": "",
            "profileName": "Batman Delivery Service", "gender": 0,
            "tagName": "Agile methodologies",
            "profilePic": "6a55c6f088f5c1c2799bac0f/IMG_20260714_111300722.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "649d80d1640c752af9ec09f5", "userId": "6a55c6f088f5c1c2799bac0f"
          },
          {
            "allowAnonymous": false, "postContent": "Hii good night sweet to you too baby to all the family and enjoy the delicious life and what is your special name of that non Busine person in your name and what was your birthday",
            "viewCount": 2, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784061295, "coordinates": [0, 0],
            "mediaUrl": "6a563d5dfc5876ac2f44b2ae/1784061259.jpg",
            "mediaType": 2, "postType": 3,
            "postId": "6a569d6f8b51d991968b656b", "thumbNail": "",
            "profileName": "Batman Franchise", "gender": 0,
            "tagName": "Agile methodologies",
            "profilePic": "6a55c6f088f5c1c2799bac0f/IMG_20260714_191007698.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "649d80d1640c752af9ec09f5", "userId": "6a55c6f088f5c1c2799bac0f"
          },
          {
            "allowAnonymous": false, "postContent": "Hiii",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784038936, "coordinates": [0, 0],
            "mediaUrl": "https://wavedinblobs.blob.core.windows.net/wavedinblobs/Videos/6a426021f1fffcbd6600ff1f/1784038933204/master.m3u8",
            "mediaType": 3, "postType": 3,
            "postId": "6a56438cfc5876ac2f44f100", "thumbNail": "",
            "profileName": "Film Studio", "gender": 0,
            "tagName": "film",
            "profilePic": "6a425a9221d082741440feb9/4F68198F-DA19-4337-8F9B-97272F7B6FFE_1782734832.png",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "6a2d6515defb034028f6ba9b", "userId": "6a426021f1fffcbd6600ff1f"
          },
          {
            "allowAnonymous": false, "postContent": "Hiii",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784038344, "coordinates": [0, 0],
            "mediaUrl": "", "mediaType": 1, "postType": 3,
            "postId": "6a5643c8fc5876ac2f44f348", "thumbNail": "",
            "profileName": "Testttttgg", "gender": 0,
            "tagName": "technology",
            "profilePic": "6a3a1b4de1f74db6a5c0525c/BB5645AC-08EB-41D6-8475-F1AB12B044B5_1782809273.png",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "649d80d1640c752af9ec0a39", "userId": "6a4382c851000000000000001"
          },
          {
            "allowAnonymous": false, "postContent": "Hello",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784037580, "coordinates": [0, 0],
            "mediaUrl": "https://wavedinblobs.blob.core.windows.net/wavedinblobs/Videos/6a426021f1fffcbd6600ff1f/1784037577291/master.m3u8",
            "mediaType": 3, "postType": 3,
            "postId": "6a563588fc5876ac2f44e200", "thumbNail": "",
            "profileName": "Film Studio", "gender": 0,
            "tagName": "technology",
            "profilePic": "6a425a9221d082741440feb9/4F68198F-DA19-4337-8F9B-97272F7B6FFE_1782734832.png",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "649d80d1640c752af9ec0a39", "userId": "6a426021f1fffcbd6600ff1f"
          },
          {
            "allowAnonymous": false, "postContent": "Hdhdrye",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784037455, "coordinates": [0, 0],
            "mediaUrl": "https://wavedinblobs.blob.core.windows.net/wavedinblobs/Videos/6a3bb3002779d5444134cb5e/1784037452744/master.m3u8",
            "mediaType": 3, "postType": 3,
            "postId": "6a563500fc5876ac2f44e100", "thumbNail": "",
            "profileName": "Mathew", "gender": 0,
            "tagName": "Agile methodologies",
            "profilePic": "64c2036cd8811405dde0e0a3/IMG_20260624_160519806.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "649d80d1640c752af9ec09f5", "userId": "6a3bb3002779d5444134cb5e"
          },
          {
            "allowAnonymous": false, "postContent": "Hiiii",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784037300, "coordinates": [0, 0],
            "mediaUrl": "https://wavedinblobs.blob.core.windows.net/wavedinblobs/Videos/6a3bb3002779d5444134cb5e/1784037297760/master.m3u8",
            "mediaType": 3, "postType": 3,
            "postId": "6a5634f0fc5876ac2f44e000", "thumbNail": "",
            "profileName": "Mathew", "gender": 0,
            "tagName": "Agile methodologies",
            "profilePic": "64c2036cd8811405dde0e0a3/IMG_20260624_160519806.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "649d80d1640c752af9ec09f5", "userId": "6a3bb3002779d5444134cb5e"
          },
          {
            "allowAnonymous": false, "postContent": "Hiiii",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784037173, "coordinates": [0, 0],
            "mediaUrl": "https://wavedinblobs.blob.core.windows.net/wavedinblobs/Videos/6a3bb3002779d5444134cb5e/1784037170426/master.m3u8",
            "mediaType": 3, "postType": 3,
            "postId": "6a5634e5fc5876ac2f44df00", "thumbNail": "",
            "profileName": "Mathew", "gender": 0,
            "tagName": "Agile methodologies",
            "profilePic": "64c2036cd8811405dde0e0a3/IMG_20260624_160519806.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "649d80d1640c752af9ec09f5", "userId": "6a3bb3002779d5444134cb5e"
          }
        ]
      }
    }
    """

    // MARK: - Page 3 (nextPage = 3)

    private static let page3 = """
    {
      "isOk": true,
      "data": {
        "currentUsername": "Mathew Joseph",
        "currentProfilePic": "64c2036cd8811405dde0e0a3/IMG_20260619_173612868.jpg",
        "currentUserGender": 2,
        "nft": 1,
        "paginator": { "pageSize": 20, "pageNumber": 4, "totalPages": 3, "nextPage": 0, "previousPage": 2 },
        "feeds": [
          {
            "allowAnonymous": false, "postContent": "Hiiii",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784037138, "coordinates": [0, 0],
            "mediaUrl": "6a3bb3002779d5444134cb5e/1784037136904.mp3",
            "mediaType": 4, "postType": 3,
            "postId": "6a563f12fc5876ac2f44c1c0", "thumbNail": "",
            "profileName": "Mathew", "gender": 0,
            "tagName": "Agile methodologies",
            "profilePic": "64c2036cd8811405dde0e0a3/IMG_20260624_160519806.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "649d80d1640c752af9ec09f5", "userId": "6a3bb3002779d5444134cb5e"
          },
          {
            "allowAnonymous": false, "postContent": "Hiiiii",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784037116, "coordinates": [0, 0],
            "mediaUrl": "", "mediaType": 1, "postType": 3,
            "postId": "6a563efcfc5876ac2f44c118", "thumbNail": "",
            "profileName": "Mathew", "gender": 0,
            "tagName": "Agile methodologies",
            "profilePic": "64c2036cd8811405dde0e0a3/IMG_20260624_160519806.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "649d80d1640c752af9ec09f5", "userId": "6a3bb3002779d5444134cb5e"
          },
          {
            "allowAnonymous": false, "postContent": "Hiii",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784037100, "coordinates": [0, 0],
            "mediaUrl": "6a3bb3002779d5444134cb5e/1784037098.jpg",
            "mediaType": 2, "postType": 3,
            "postId": "6a563eecfc5876ac2f44c068", "thumbNail": "",
            "profileName": "Mathew", "gender": 0,
            "tagName": "Agile methodologies",
            "profilePic": "64c2036cd8811405dde0e0a3/IMG_20260624_160519806.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "649d80d1640c752af9ec09f5", "userId": "6a3bb3002779d5444134cb5e"
          },
          {
            "allowAnonymous": false, "postContent": "Good",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784034333, "coordinates": [0, 0],
            "mediaUrl": "https://wavedinblobs.blob.core.windows.net/wavedinblobs/Videos/6a562568be7e08708c04ca77/1784034330112/master.m3u8",
            "mediaType": 3, "postType": 3,
            "postId": "6a5634ccfc5876ac2f446000", "thumbNail": "",
            "profileName": "Franchise 2", "gender": 0,
            "tagName": "boating",
            "profilePic": "6a5624a7be7e08708c04c3d2/IMG_20260714_173143589.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "6a56022e1019368a0e9b0000", "userId": "6a562568be7e08708c04ca77"
          },
          {
            "allowAnonymous": false, "postContent": "Hello",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784034252, "coordinates": [0, 0],
            "mediaUrl": "6a562568be7e08708c04ca77/1784034250245.mp3",
            "mediaType": 4, "postType": 3,
            "postId": "6a5633ccfc5876ac2f445fb4", "thumbNail": "",
            "profileName": "Franchise 2", "gender": 0,
            "tagName": "Blockchain technology",
            "profilePic": "6a5624a7be7e08708c04c3d2/IMG_20260714_173143589.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "649d80d1640c752af9ec0a39", "userId": "6a562568be7e08708c04ca77"
          },
          {
            "allowAnonymous": false, "postContent": "Good",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784034148, "coordinates": [0, 0],
            "mediaUrl": "6a562568be7e08708c04ca77/1784034145.jpg",
            "mediaType": 2, "postType": 3,
            "postId": "6a563364fc5876ac2f445cae", "thumbNail": "",
            "profileName": "Franchise 2", "gender": 0,
            "tagName": "Business ethics",
            "profilePic": "6a5624a7be7e08708c04c3d2/IMG_20260714_173143589.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "649d80d1640c752af9ec0a16", "userId": "6a562568be7e08708c04ca77"
          },
          {
            "allowAnonymous": false, "postContent": "Hiiiiiiiii",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784034112, "coordinates": [0, 0],
            "mediaUrl": "", "mediaType": 1, "postType": 3,
            "postId": "6a563340fc5876ac2f445b41", "thumbNail": "",
            "profileName": "Franchise 2", "gender": 0,
            "tagName": "Budgeting & financial planning",
            "profilePic": "6a5624a7be7e08708c04c3d2/IMG_20260714_173143589.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "649d80d1640c752af9ec09f8", "userId": "6a562568be7e08708c04ca77"
          },
          {
            "allowAnonymous": false, "postContent": "Hello",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784034071, "coordinates": [0, 0],
            "mediaUrl": "6a562568be7e08708c04ca77/1784034068861.ppt",
            "mediaType": 5, "postType": 3,
            "postId": "6a563317fc5876ac2f445958", "thumbNail": "",
            "profileName": "Franchise 2", "gender": 0,
            "tagName": "Agile methodologies",
            "profilePic": "6a5624a7be7e08708c04c3d2/IMG_20260714_173143589.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "649d80d1640c752af9ec09f5", "userId": "6a562568be7e08708c04ca77"
          },
          {
            "allowAnonymous": false, "postContent": "The only way I could see him",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784032241, "coordinates": [0, 0],
            "mediaUrl": "https://wavedinblobs.blob.core.windows.net/wavedinblobs/Videos/6a4fa4a19b137070bd75ac9b/1784032237692/master.m3u8",
            "mediaType": 3, "postType": 3,
            "postId": "6a561e00be7e08708c048000", "thumbNail": "",
            "profileName": "Without Pay Using D Code", "gender": 0,
            "tagName": "apple",
            "profilePic": "6a4fa40a637ab3bc04e57af3/IMG_20260709_190840565.jpg",
            "bgColor": "", "textColor": "",
            "tagId": "6a56022e1019368a0e9b0001", "userId": "6a4fa4a19b137070bd75ac9b"
          },
          {
            "allowAnonymous": false, "postContent": "Goood",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784029416, "coordinates": [0, 0],
            "mediaUrl": "https://wavedinblobs.blob.core.windows.net/wavedinblobs/Videos/6a54d25755daea6b4ea9db08/1784029412834/master.m3u8",
            "mediaType": 3, "postType": 3,
            "postId": "6a561e00be7e08708c048001", "thumbNail": "",
            "profileName": "Payment New Notification", "gender": 0,
            "tagName": "Agile methodologies",
            "profilePic": "6a4f76c5521893cdbb87e5dc/IMG_20260713_172503568.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "649d80d1640c752af9ec09f5", "userId": "6a54d25755daea6b4ea9db08"
          },
          {
            "allowAnonymous": false, "postContent": "Hiiiiii",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784029347, "coordinates": [0, 0],
            "mediaUrl": "https://wavedinblobs.blob.core.windows.net/wavedinblobs/Videos/6a54d25755daea6b4ea9db08/1784029343548/master.m3u8",
            "mediaType": 3, "postType": 3,
            "postId": "6a561e00be7e08708c048002", "thumbNail": "",
            "profileName": "Payment New Notification", "gender": 0,
            "tagName": "Agile methodologies",
            "profilePic": "6a4f76c5521893cdbb87e5dc/IMG_20260713_172503568.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "649d80d1640c752af9ec09f5", "userId": "6a54d25755daea6b4ea9db08"
          },
          {
            "allowAnonymous": false, "postContent": "Newww",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784029211, "coordinates": [0, 0],
            "mediaUrl": "https://wavedinblobs.blob.core.windows.net/wavedinblobs/Videos/6a54d25755daea6b4ea9db08/1784029207281/master.m3u8",
            "mediaType": 3, "postType": 3,
            "postId": "6a561e00be7e08708c048003", "thumbNail": "",
            "profileName": "Payment New Notification", "gender": 0,
            "tagName": "banking",
            "profilePic": "6a4f76c5521893cdbb87e5dc/IMG_20260713_172503568.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "6a56022e1019368a0e9b0002", "userId": "6a54d25755daea6b4ea9db08"
          },
          {
            "allowAnonymous": false, "postContent": "Hiii",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784028899, "coordinates": [0, 0],
            "mediaUrl": "6a4f7c49278d8de0996f9192/1784028896943.mp3",
            "mediaType": 4, "postType": 3,
            "postId": "6a561ee3be7e08708c049300", "thumbNail": "",
            "profileName": "Payment Skip", "gender": 0,
            "tagName": "goodbye",
            "profilePic": "6a4f76c5521893cdbb87e5dc/IMG_20260709_161643240.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "6a56022e1019368a0e9b0003", "userId": "6a4f7c49278d8de0996f9192"
          },
          {
            "allowAnonymous": false, "postContent": "Hello",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784028859, "coordinates": [0, 0],
            "mediaUrl": "", "mediaType": 1, "postType": 3,
            "postId": "6a561ebbbe7e08708c049253", "thumbNail": "",
            "profileName": "Payment Skip", "gender": 0,
            "tagName": "bookings",
            "profilePic": "6a4f76c5521893cdbb87e5dc/IMG_20260709_161643240.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "6a56022e1019368a0e9b0004", "userId": "6a4f7c49278d8de0996f9192"
          },
          {
            "allowAnonymous": false, "postContent": "Newwww",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784028824, "coordinates": [0, 0],
            "mediaUrl": "", "mediaType": 1, "postType": 3,
            "postId": "6a561e98be7e08708c049104", "thumbNail": "",
            "profileName": "Payment Skip", "gender": 0,
            "tagName": "Agile methodologies",
            "profilePic": "6a4f76c5521893cdbb87e5dc/IMG_20260709_161643240.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "649d80d1640c752af9ec09f5", "userId": "6a4f7c49278d8de0996f9192"
          },
          {
            "allowAnonymous": false, "postContent": "Hii namaste namaste I am not able",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784028722, "coordinates": [0, 0],
            "mediaUrl": "https://wavedinblobs.blob.core.windows.net/wavedinblobs/Videos/6a4f7c49278d8de0996f9192/1784028718389/master.m3u8",
            "mediaType": 3, "postType": 3,
            "postId": "6a561e80be7e08708c049000", "thumbNail": "",
            "profileName": "Payment Skip", "gender": 0,
            "tagName": "boating",
            "profilePic": "6a4f76c5521893cdbb87e5dc/IMG_20260709_161643240.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "6a56022e1019368a0e9b0005", "userId": "6a4f7c49278d8de0996f9192"
          },
          {
            "allowAnonymous": false, "postContent": "Hello",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784028670, "coordinates": [0, 0],
            "mediaUrl": "6a4f7c49278d8de0996f9192/1784028667.jpg",
            "mediaType": 2, "postType": 3,
            "postId": "6a561dfebe7e08708c0487a9", "thumbNail": "",
            "profileName": "Payment Skip", "gender": 0,
            "tagName": "boating",
            "profilePic": "6a4f76c5521893cdbb87e5dc/IMG_20260709_161643240.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "6a56022e1019368a0e9b0006", "userId": "6a4f7c49278d8de0996f9192"
          },
          {
            "allowAnonymous": false, "postContent": "Hiiiii",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784028630, "coordinates": [0, 0],
            "mediaUrl": "", "mediaType": 1, "postType": 3,
            "postId": "6a561dd6be7e08708c04866c", "thumbNail": "",
            "profileName": "Payment Skip", "gender": 0,
            "tagName": "Watch",
            "profilePic": "6a4f76c5521893cdbb87e5dc/IMG_20260709_161643240.jpg",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "6a56022e1019368a0e9b0007", "userId": "6a4f7c49278d8de0996f9192"
          },
          {
            "allowAnonymous": false, "postContent": "Hi",
            "viewCount": 0, "threadCount": 0, "clapCount": 0,
            "createdDate": 1784011860, "coordinates": [0, 0],
            "mediaUrl": "6a52509efed9cd0841ceaac8/1784011857.jpg",
            "mediaType": 2, "postType": 3,
            "postId": "6a55dc541019368a0e9a3b31", "thumbNail": "",
            "profileName": "Anonymous User", "gender": 0,
            "tagName": "Agile methodologies",
            "profilePic": "",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "649d80d1640c752af9ec09f5", "userId": "6a52509efed9cd0841ceaac8"
          },
          {
            "allowAnonymous": false, "postContent": "Gsg",
            "viewCount": 1, "threadCount": 0, "clapCount": 0,
            "createdDate": 1783982809, "coordinates": [0, 0],
            "mediaUrl": "6a3e8663523306a0cddde894/1783982807411.mp3",
            "mediaType": 4, "postType": 3,
            "postId": "6a556ad988f5c1c2799b2f0d", "thumbNail": "",
            "profileName": "Battery check 2", "gender": 0,
            "tagName": "Blockchain technology",
            "profilePic": "6a3e7cc841e6ef2ba3ad0e5a/0D3CB8AD-76F3-48CE-B3E7-E1854ACAE82E_1782482519.png",
            "bgColor": "#334257", "textColor": "#ffffff",
            "tagId": "649d80d1640c752af9ec0a39", "userId": "6a3e8663523306a0cddde894"
          }
        ]
      }
    }
    """
}
