import SwiftUI

protocol ColorThemeProtocol {
    var primaryColor: Color { get }
    var secondaryColor: Color { get }
    var tertiaryColor: Color { get }
    var quaternaryColor: Color { get }
}

struct DefaultColorTheme: ColorThemeProtocol {
    let primaryColor = Color(#colorLiteral(red: 0, green: 0.3647865585, blue: 0.6696527654, alpha: 1))
    let secondaryColor = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    let tertiaryColor = Color(#colorLiteral(red: 0.006381089494, green: 0.02289956386, blue: 0.06112023556, alpha: 1))
    let quaternaryColor = Color(#colorLiteral(red: 0.1090566104, green: 0.1090566104, blue: 0.1090566104, alpha: 0.5))
}
