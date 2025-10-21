// ContentView.swift
// burası programın ekran kısmı, yani kullanıcı kodu buraya yazıyor ve altta sonuçları görüyor

import SwiftUI

struct ContentView: View {
    // kullanıcının yazdığı kod burda tutuluyor
    @State private var codeText = ""
    
    // çıkan token’ları burda tutuyorum
    @State private var tokens: [Token] = []

    var body: some View {
        VStack {
            // üstte başlık kısmı
            Text("Lexical Analyzer")
                .font(.title)
                .padding()

            // kod yazılan alan
            TextEditor(text: $codeText)
                .border(Color.gray) // kenarlık ekledim
                .frame(height: 200) // kutunun boyunu ayarladım
                .padding()

            // analiz et butonu
            Button("Analiz Et") {
                // Lexer sınıfını çağırıyorum, kodu içine veriyorum
                let lexer = Lexer(code: codeText)
                
                // analizi çalıştırıyorum
                lexer.analyze()
                
                // çıkan sonuçları tokens listesine atıyorum
                tokens = lexer.tokens
            }
            .padding()
            .buttonStyle(.borderedProminent) // butonun görünümünü biraz belirgin yaptım

            // tokenları liste şeklinde gösteriyorum
            List(tokens, id: \.lexeme) { token in
                HStack {
                    // kelimenin kendisi
                    Text(token.lexeme)
                        .frame(width: 100, alignment: .leading)
                    Spacer()
                    
                    // token tipi (örneğin keyword, identifier vs)
                    Text(token.type.rawValue)
                        .frame(width: 100, alignment: .leading)
                    Spacer()
                    
                    // satır ve sütun numarası
                    Text("Satır: \(token.line)")
                    Text("Sütun: \(token.column)")
                }
            }
            .frame(height: 250) // listenin boyunu ayarladım
        }
        .padding() // dış kenarlardan biraz boşluk verdim
    }
}

// bu da xcode’da önizleme kısmı (tasarımı görebilmek için)
#Preview {
    ContentView()
}
