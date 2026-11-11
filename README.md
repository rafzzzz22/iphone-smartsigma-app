# 📱 Projeto Xcode + GitHub Actions (Gerar e Baixar App `.ipa` no iPhone sem Mac)

Este projeto permite compilar um aplicativo iOS real (**SwiftUI Nativo + WebView Tela Cheia**) usando os servidores **macOS com Xcode** gratuitos do **GitHub Actions**, gerando automaticamente o arquivo instalável **`SmartSigmaApp.ipa`** para instalar no seu iPhone usando apenas o Windows.

---

## 🚀 Passo a Passo Rápido (Do Windows para o iPhone)

### Passo 1 — Subir o projeto para o seu GitHub
1. Dê dois cliques no arquivo **[`PUBLICAR_NO_GITHUB.bat`](file:///C:/Users/Smart%20Sigma/.gemini/antigravity/scratch/iphone-xcode-github-app/PUBLICAR_NO_GITHUB.bat)** (ou suba esta pasta para um repositório no seu GitHub).
2. Assim que o código entrar no GitHub, o workflow [`.github/workflows/build-ipa.yml`](file:///C:/Users/Smart%20Sigma/.gemini/antigravity/scratch/iphone-xcode-github-app/.github/workflows/build-ipa.yml) inicia automaticamente uma máquina **macOS com Xcode 15/16**.
3. Em cerca de **2 a 3 minutos**, o GitHub termina a compilação e publica o arquivo **`SmartSigmaApp.ipa`** em dois lugares do seu repositório:
   - Na aba **Releases** (na lateral direita do GitHub, pronto para clicar e baixar direto no iPhone ou PC).
   - Na aba **Actions** → clique na execução concluída → seção **Artifacts** (`SmartSigmaApp-iPhone-IPA`).

---

### Passo 2 — Como Instalar o `.ipa` no iPhone (3 Métodos Gratuitos)

Como a Apple exige assinatura digital para instalar fora da App Store, escolha **qualquer uma** das ferramentas gratuitas abaixo para assinar e instalar seu `SmartSigmaApp.ipa` no iPhone:

#### Opção A: Usando o **Sideloadly** no Windows (Mais fácil e rápido)
1. Baixe e instale o **[Sideloadly](https://sideloadly.io/)** no seu Windows (requer iTunes e iCloud versão site da Apple instalados).
2. Conecte seu iPhone no PC via cabo USB (e confie no computador na tela do iPhone).
3. Abra o **Sideloadly**, arraste o arquivo **`SmartSigmaApp.ipa`** que você baixou do GitHub.
4. Digite seu **Apple ID (e-mail da conta Apple)** — pode ser conta gratuita normal.
5. Clique em **Start**. Em segundos o ícone do app aparecerá na tela inicial do seu iPhone!
6. **Para abrir na 1ª vez**: No iPhone, vá em **Ajustes → Geral → Gestão de VPN e Dispositivo**, toque no seu e-mail e toque em **Confiar**.
   - *(Dica: Ative o Wi-Fi Sync no Sideloadly para ele renovar automaticamente a assinatura de 7 dias pela rede Wi-Fi sem precisar de cabo!)*

#### Opção B: Direto pelo iPhone com **AltStore / SideStore**
1. Baixe o arquivo `SmartSigmaApp.ipa` pelo Safari no próprio iPhone (acessando a aba **Releases** do seu GitHub).
2. Abra o app **SideStore** ou **AltStore** no iPhone → aba **My Apps** → toque no botão **`+`** no topo e selecione o `SmartSigmaApp.ipa`.

#### Opção C: Direto pelo iPhone com Certificado / **Feather / ESign / TrollStore**
1. Baixe o `SmartSigmaApp.ipa` no aplicativo **Arquivos** do iPhone.
2. Importe no **Feather**, **ESign** ou **TrollStore** e toque em **Instalar**.

---

## 🛠️ Como Personalizar o App (Nome, Ícone ou Abrir seu Sistema Web / Home Assistant)

Você pode personalizar sem tocar em código de duas maneiras:

1. **Pelo próprio site do GitHub (sem editar arquivos):**
   - No seu repositório GitHub, clique na aba **Actions** → selecione **Build iOS IPA (Xcode Cloud via GitHub Actions)** → clique no botão **Run workflow**.
   - Preencha os campos opcionais:
     - **Nome do App no iPhone**: Ex: `Smart Sigma`
     - **Bundle Identifier**: Ex: `com.smartsigma.app`
     - **URL opcional**: Se você preencher (ex: `http://192.168.1.100:8123` ou `https://seu-painel.com`), o app já será compilado abrindo direto em **Tela Cheia (Modo Kiosk/App Nativo)** nesse endereço!

2. **Editando o código antes de enviar:**
   - [`Sources/AppConfig.swift`](file:///C:/Users/Smart%20Sigma/.gemini/antigravity/scratch/iphone-xcode-github-app/Sources/AppConfig.swift): Altere título, URL padrão e modo tela cheia.
   - [`Sources/ContentView.swift`](file:///C:/Users/Smart%20Sigma/.gemini/antigravity/scratch/iphone-xcode-github-app/Sources/ContentView.swift): Altere as telas nativas em SwiftUI.
   - [`project.yml`](file:///C:/Users/Smart%20Sigma/.gemini/antigravity/scratch/iphone-xcode-github-app/project.yml): Configurações do Xcode (versão do iOS, Bundle ID, permissões).
