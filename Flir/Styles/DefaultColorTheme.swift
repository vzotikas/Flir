import SwiftUI

protocol ColorThemeProtocol {
    var primaryColor: Color { get }
    var secondaryColor: Color { get }
    var tertiaryColor: Color { get }
    var quaternaryColor: Color { get }
    var gradient: LinearGradient {get}
}

struct DefaultColorTheme: ColorThemeProtocol {
    let primaryColor = Color(#colorLiteral(red: 0, green: 0.3647865585, blue: 0.6696527654, alpha: 1))
    let secondaryColor = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    let tertiaryColor = Color(#colorLiteral(red: 0.006381089494, green: 0.02289956386, blue: 0.06112023556, alpha: 1))
    let quaternaryColor = Color(#colorLiteral(red: 0.1090566104, green: 0.1090566104, blue: 0.1090566104, alpha: 0.5))
    let gradient = LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hue: 0.5890869692147497, saturation: 0.7570247420345445, brightness: 0.3924503096614976, opacity: 1.0), location: 0.0), Gradient.Stop(color: Color(hue: 0.6, saturation: 1.0, brightness: 0.12792784909167923, opacity: 1.0), location: 0.507611553485577), Gradient.Stop(color: Color(hue: 0.8346959309405592, saturation: 1.0, brightness: 0.3181611945830196, opacity: 1.0), location: 1.0)]), startPoint: UnitPoint.topLeading, endPoint: UnitPoint.bottomTrailing)
}
