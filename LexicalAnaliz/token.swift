// Token.swift
// burası token türlerini ve her token’ın içinde neler olacağını tanımladığım yer

import Foundation

// hangi türlerde token olacağını burda yazıyorum
enum TokenType: String {
    case keyword      = "KEYWORD"     // özel kelimeler (if, while falan)
    case identifier   = "IDENTIFIER"  // değişken isimleri
    case number       = "NUMBER"      // sayılar
    case operatorSym  = "OPERATOR"    // + - * / = gibi şeyler
    case unknown      = "UNKNOWN"     // tanımadığım karakterler

}

// her bir token’ın içinde hangi bilgiler olacak
struct Token {
    let type: TokenType  // tipi (örnek: keyword, number)
    let lexeme: String   // kelimenin kendisi
    let line: Int        // satır numarası
    let column: Int      // sütun numarası
}
