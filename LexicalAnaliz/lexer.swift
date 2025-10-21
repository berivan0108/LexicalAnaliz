// Lexer.swift
// Bu sınıfta yazdığımız kodu okuyup anlamlı parçalara ayırıyoruz (token).
// Yani burası bizim Lexical Analyzer kısmı.

import Foundation

class Lexer {
    let code: String // Kullanıcının yazdığı kod
    var tokens: [Token] = [] // Bulduğumuz token'ları burada tutuyoruz
    var keywords: [String] = ["if", "while", "return", "int", "float"] // Anahtar kelimeler

    init(code: String) {
        // Kod geldiğinde ilk iş olarak yorum satırlarını siliyoruz
        self.code = Lexer.removeComments(from: code)
    }

    // Yorum satırlarını temizleyen basit fonksiyon
    static func removeComments(from code: String) -> String {
        var newCode = ""
        let lines = code.split(separator: "\n", omittingEmptySubsequences: false)
        
        for line in lines {
            // Satırda // varsa, oradan sonrası yorum sayılır, silinir
            if let commentIndex = line.firstIndex(of: "/"),
               line.distance(from: commentIndex, to: line.endIndex) > 1,
               line[line.index(after: commentIndex)] == "/" {
                let cleanLine = line[..<commentIndex]
                newCode += cleanLine + "\n"
            } else {
                newCode += line + "\n"
            }
        }
        return newCode
    }

    // Kodun analizini yapan ana fonksiyon
    func analyze() {
        var line = 1
        var column = 1
        var index = code.startIndex

        // Kod bitene kadar karakter karakter ilerliyoruz
        while index < code.endIndex {
            let char = code[index]

            // Satır sonuna geldiysek alt satıra geçiyoruz
            if char == "\n" {
                line += 1
                column = 1
                index = code.index(after: index)
                continue
            }

            // Boşlukları atlıyoruz
            if char.isWhitespace {
                column += 1
                index = code.index(after: index)
                continue
            }

            // Eğer karakter harfse -> identifier ya da keyword olabilir
            if char.isLetter {
                var currentLexeme = String(char)
                var nextIndex = code.index(after: index)

                // Harf ya da rakam geldikçe kelimeye ekliyoruz
                while nextIndex < code.endIndex {
                    let nextChar = code[nextIndex]
                    if nextChar.isLetter || nextChar.isNumber {
                        currentLexeme.append(nextChar)
                        nextIndex = code.index(after: nextIndex)
                    } else {
                        break
                    }
                }

                // Eğer kelime anahtar kelimeler listesinde varsa KEYWORD, yoksa IDENTIFIER
                let tokenType: TokenType = keywords.contains(currentLexeme)
                    ? .keyword : .identifier

                tokens.append(Token(type: tokenType, lexeme: currentLexeme, line: line, column: column))
                column += currentLexeme.count
                index = nextIndex
                continue
            }

            // Eğer sayıysa
            if char.isNumber {
                var currentLexeme = String(char)
                var nextIndex = code.index(after: index)

                // Sonuna kadar oku
                while nextIndex < code.endIndex {
                    let nextChar = code[nextIndex]
                    if nextChar.isNumber {
                        currentLexeme.append(nextChar)
                        nextIndex = code.index(after: nextIndex)
                    } else {
                        break
                    }
                }

                tokens.append(Token(type: .number, lexeme: currentLexeme, line: line, column: column))
                column += currentLexeme.count
                index = nextIndex
                continue
            }
            // Operatörler (bunları token olarak bırakıyoruz)
            if "+-*/=".contains(char) {
                tokens.append(Token(type: .operatorSym, lexeme: String(char), line: line, column: column))
                column += 1
                index = code.index(after: index)
                continue
            }

            // AYIRICILAR (delimiter) -> artık token olarak eklemiyoruz, sadece atlıyoruz
            if ";{}()".contains(char) {
                // delimiter istemediğin için buraya token eklemiyorum
                column += 1
                index = code.index(after: index)
                continue
            }

            // Yukarıdakilere uymayan karakterler "unknown" olarak işaretlenir
            tokens.append(Token(type: .unknown, lexeme: String(char), line: line, column: column))
            column += 1
            index = code.index(after: index)
        } // while kapanışı
    } // func analyze kapanışı
} // class kapanışı
