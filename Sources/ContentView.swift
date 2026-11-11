import SwiftUI
import WebKit

struct ContentView: View {
    @AppStorage("saved_web_url") private var savedWebURL: String = AppConfig.defaultWebURL
    @AppStorage("start_in_web_mode") private var isFullScreenWeb: Bool = AppConfig.startInWebViewMode
    @State private var selectedTab: Int = 0
    @State private var customURLInput: String = ""
    @State private var hapticTrigger: Bool = false
    @State private var quickActions: [QuickActionItem] = [
        QuickActionItem(title: "Cenário Cinema", subtitle: "Luzes 15% • TV Ligada", icon: "film.fill", isOn: true),
        QuickActionItem(title: "Climatização Sala", subtitle: "Ar-condicionado 22°C", icon: "snowflake", isOn: true),
        QuickActionItem(title: "Iluminação Principal", subtitle: "Recepção & Estar", icon: "lightbulb.fill", isOn: false),
        QuickActionItem(title: "Modo Segurança", subtitle: "Sensores e Câmeras Ativos", icon: "shield.lefthalf.filled", isOn: true)
    ]

    var body: some View {
        Group {
            if isFullScreenWeb {
                ZStack(alignment: .bottomTrailing) {
                    WebViewContainer(urlString: savedWebURL)
                        .ignoresSafeArea()

                    Button(action: {
                        withAnimation(.easeOut(duration: 0.2)) {
                            isFullScreenWeb = false
                        }
                    }) {
                        Image(systemName: "slider.horizontal.3")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(14)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.white.opacity(0.2), lineWidth: 1)
                            )
                            .shadow(color: .black.opacity(0.35), radius: 8, x: 0, y: 4)
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 24)
                    .accessibilityLabel("Voltar ao menu nativo")
                }
            } else {
                TabView(selection: $selectedTab) {
                    nativeDashboardTab
                        .tabItem {
                            Label("Painel", systemImage: "square.grid.2x2.fill")
                        }
                        .tag(0)

                    webPortalTab
                        .tabItem {
                            Label("Web App", systemImage: "globe")
                        }
                        .tag(1)

                    settingsTab
                        .tabItem {
                            Label("Ajustes", systemImage: "gearshape.fill")
                        }
                        .tag(2)
                }
                .tint(Color(red: 0.85, green: 0.68, blue: 0.32))
            }
        }
        .onAppear {
            customURLInput = savedWebURL
        }
    }

    // MARK: - Aba 1: Dashboard Nativo iOS
    private var nativeDashboardTab: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Header Card
                    HStack(spacing: 16) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(Color(red: 0.85, green: 0.68, blue: 0.32).opacity(0.18))
                                .frame(width: 56, height: 56)
                            Image(systemName: "iphone.gen3.radiowaves.left.and.right")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(Color(red: 0.85, green: 0.68, blue: 0.32))
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text(AppConfig.appTitle)
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.white)
                            Text("App Nativo iOS compilado via GitHub Actions")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding(18)
                    .background(Color(white: 0.11))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(Color.white.opacity(0.08), lineWidth: 1)
                    )

                    // Botão rápido para modo Web Fullscreen
                    Button(action: {
                        withAnimation(.easeOut(duration: 0.2)) {
                            isFullScreenWeb = true
                        }
                    }) {
                        HStack {
                            Image(systemName: "arrow.up.left.and.arrow.down.right")
                                .font(.system(size: 16, weight: .semibold))
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Abrir Sistema Web em Tela Cheia")
                                    .font(.system(size: 15, weight: .semibold))
                                Text(savedWebURL)
                                    .font(.system(size: 12))
                                    .opacity(0.8)
                                    .lineLimit(1)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .bold))
                        }
                        .foregroundColor(.black)
                        .padding(16)
                        .background(Color(red: 0.85, green: 0.68, blue: 0.32))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    }

                    Text("CONTROLES RÁPIDOS")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.gray)
                        .tracking(1.2)
                        .padding(.top, 4)

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                        ForEach($quickActions) { $item in
                            Button(action: {
                                withAnimation(.easeOut(duration: 0.15)) {
                                    item.isOn.toggle()
                                }
                            }) {
                                VStack(alignment: .leading, spacing: 12) {
                                    HStack {
                                        Image(systemName: item.icon)
                                            .font(.system(size: 20, weight: .semibold))
                                            .foregroundColor(item.isOn ? Color(red: 0.85, green: 0.68, blue: 0.32) : .gray)
                                        Spacer()
                                        Circle()
                                            .fill(item.isOn ? Color.green : Color.gray.opacity(0.3))
                                            .frame(width: 8, height: 8)
                                    }

                                    Text(item.title)
                                        .font(.system(size: 15, weight: .semibold))
                                        .foregroundColor(.white)
                                        .lineLimit(1)

                                    Text(item.subtitle)
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                        .lineLimit(1)
                                }
                                .padding(16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(item.isOn ? Color(white: 0.14) : Color(white: 0.09))
                                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                                        .stroke(
                                            item.isOn
                                                ? Color(red: 0.85, green: 0.68, blue: 0.32).opacity(0.45)
                                                : Color.white.opacity(0.06),
                                            lineWidth: 1
                                        )
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(20)
            }
            .background(Color(white: 0.05).ignoresSafeArea())
            .navigationTitle("Smart Sigma")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // MARK: - Aba 2: Web App Integrado
    private var webPortalTab: some View {
        NavigationStack {
            WebViewContainer(urlString: savedWebURL)
                .ignoresSafeArea(edges: .bottom)
                .navigationTitle("Web App")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Tela Cheia") {
                            isFullScreenWeb = true
                        }
                    }
                }
        }
    }

    // MARK: - Aba 3: Ajustes
    private var settingsTab: some View {
        NavigationStack {
            Form {
                Section(header: Text("Endereço do Sistema Web / Dashboard")) {
                    TextField("https://seu-painel.com", text: $customURLInput)
                        .keyboardType(.URL)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)

                    Button("Salvar Endereço URL") {
                        let trimmed = customURLInput.trimmingCharacters(in: .whitespacesAndNewlines)
                        if !trimmed.isEmpty {
                            savedWebURL = trimmed
                        }
                    }
                }

                Section(header: Text("Modo de Inicialização")) {
                    Toggle("Iniciar direto em Tela Cheia (Modo Kiosk/Web)", isOn: $isFullScreenWeb)
                }

                Section(header: Text("Sobre a Compilação")) {
                    HStack {
                        Text("Plataforma")
                        Spacer()
                        Text("iOS 16.0+ (SwiftUI)")
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("Gerador Xcode")
                        Spacer()
                        Text("GitHub Actions + XcodeGen")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Ajustes do App")
        }
    }
}

struct QuickActionItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
    var isOn: Bool
}

// MARK: - WKWebView Wrapper Nativo
struct WebViewContainer: UIViewRepresentable {
    let urlString: String

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.isOpaque = false
        webView.backgroundColor = .black
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        guard let url = URL(string: urlString) else { return }
        if webView.url?.absoluteString != url.absoluteString {
            webView.load(URLRequest(url: url))
        }
    }
}
