//
//  ContentDetailViewModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/30.
//

import Foundation
import Combine

class ContentDetailViewModel: ObservableObject {
    
    let NM = NetworkManager.shared
    var cancellables = Set<AnyCancellable>()
    
    @Published var content: ContentDetailModel = ContentDetailModel(contentNum: 0, contentTitle: "", contentText: "", contentDate: "", contentLook: "", userNickName: "")
    
    func getContent(userUUID: String, contentId: Int) {
        guard let url = URL(string: NM.facilityIp + "/api/facility/content/" + String(contentId)) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(getFacilitiesHandleOutput)
            .decode(type: ContentDetailModel.self, decoder: JSONDecoder())
            .replaceError(with: ContentDetailModel(contentNum: 1, contentTitle: "", contentText: "", contentDate: "", contentLook: "", userNickName: ""))
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] returnedValue in
                print("-----> 리턴 벨류\(returnedValue)")
                self?.content = returnedValue
            }
            .store(in: &cancellables)
    }
    
    func getFacilitiesHandleOutput(output: Publishers.SubscribeOn<URLSession.DataTaskPublisher, DispatchQueue>.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode == 200
        else { throw URLError(.badServerResponse) }

        print("response.StatusCode == \(response.statusCode), data == \(String(decoding: output.data, as: UTF8.self))")
        
        return output.data
    }
    
}
