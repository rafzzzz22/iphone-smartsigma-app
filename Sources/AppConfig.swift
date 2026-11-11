import Foundation

struct AppConfig {
    /// Nome exibido no cabeçalho do app
    static let appTitle: String = "Smart Sigma"
    
    /// Subtítulo / ambiente
    static let appSubtitle: String = "iOS Native & Web Controller"
    
    /// Se `true`, o app abre direto em tela cheia na URL configurada abaixo (ideal para painéis Web / Home Assistant)
    static let startInWebViewMode: Bool = false
    
    /// URL padrão carregada no modo Web App / Painel
    static let defaultWebURL: String = "https://demo.home-assistant.io"
}
