//
//  Settings.swift
//  PiHoleStats
//
//  Created by Fernando Bunn on 11/05/2020.
//  Copyright © 2020 Fernando Bunn. All rights reserved.
//

import Foundation
import Combine

private enum SettingsKey: String {
    case address = "SettingsKeyHost"
}

class Settings: ObservableObject {
    var keychainToken = APIToken()
    
    init() {
        apiToken = keychainToken.token
    }

    @Published var address: String = UserDefaults.standard.object(forKey: SettingsKey.address.rawValue) as? String ?? "" {
        didSet {
            UserDefaults.standard.set(address, forKey: SettingsKey.address.rawValue)
        }
    }
    
    @Published var apiToken: String  {
        didSet {
            keychainToken.token = apiToken
        }
    }
    
    var port: Int? {
        getPort(address)
    }
    
    var host: String {
        address.components(separatedBy: ":").first ?? ""
    }

    private func getPort(_ address: String) -> Int? {
        let split = address.components(separatedBy: ":")
        guard let port = split.last else { return nil }
        return Int(port)
    }
}
