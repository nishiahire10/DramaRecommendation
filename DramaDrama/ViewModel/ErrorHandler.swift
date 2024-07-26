//
//  ErrorHandler.swift
//  DramaDrama
//
//  Created by Nishigandha Bhushan Jadhav on 26/07/24.
//

import Foundation

class ErrorHandler {
    
    func handleError(error : DecodingError) -> String {
        switch error as DecodingError {
        case .typeMismatch(let type, let context) :
            print("Type mismatch at \(context.codingPath): \(context.debugDescription)")
            return "Type '\(type)' mismatch: \(context.debugDescription)"
        case .valueNotFound(let type, let context):
            print("Value not found at \(context.codingPath): \(context.debugDescription)")
            return "Value '\(type)' not found: \(context.debugDescription)"
        case .keyNotFound(let key, let context):
            print("Key not found at \(context.codingPath): \(context.debugDescription)")
            return "Key '\(key)' not found: \(context.debugDescription)"
        case .dataCorrupted(let context):
            print("Data corrupted at \(context.codingPath): \(context.debugDescription)")
            return "Data corrupted: \(context.debugDescription)"
        @unknown default:
            return "Unknown decoding error"
        }
    }
}
