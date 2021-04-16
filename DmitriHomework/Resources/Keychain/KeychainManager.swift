//
//  KeychainManager.swift
//  DmitriHomework
//
//  Created by Ruben Nahatakyan on 16.04.21.
//

import KeychainAccess
import UIKit

class KeychainManager: NSObject {
    // MARK: - Properites
    private let keychain = Keychain(service: "am.Nahatakyan.DmitriHomework")

    // MARK: - Static
    static let shared = KeychainManager()

    // MARK: - Init
    override private init() {
        super.init()
    }
}

// MARK: - Public methods
extension KeychainManager {
    public func save(value: String?, to: KeychainObjectsEnum) {
        keychain[to.rawValue] = value
    }

    public func get(name: KeychainObjectsEnum) -> String? {
        return keychain[name.rawValue]
    }
}

// MARK: - Helpers
enum KeychainObjectsEnum: String {
    case token = "request_token"
}
