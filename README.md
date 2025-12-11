# 🏠 Smart Home JaCaMo - Sistema Multiagente

Este projeto é uma simulação de uma Casa Inteligente (Smart Home) desenvolvida utilizando o framework **JaCaMo** (Jason + CArtAgO + Moise). O sistema utiliza agentes BDI (Belief-Desire-Intention) para controlar dispositivos da casa baseados em percepções capturadas por uma câmera simulada.

## 📋 Sobre o Projeto

O objetivo é demonstrar a coordenação entre diferentes agentes autônomos que controlam atuadores (Luz, Ar Condicionado, Cortina, Fechadura) em resposta a eventos do ambiente. O sistema implementa cenários de conforto para o proprietário e protocolos de segurança contra intrusos.

### 🤖 Agentes do Sistema

O sistema é composto pelos seguintes agentes (localizados em `src/agt/`):

1. **`camera`**: O "cérebro" da percepção. Monitora o ambiente através da GUI, identifica pessoas e locais, e coordena os demais agentes enviando comandos.
2. **`ar_condicionado`**: Controla a temperatura ambiente. Possui preferências de usuário (25°C para o proprietário) e modos de ação extremos para segurança.
3. **`lampada`**: Controla a iluminação artificial (Ligar/Desligar).
4. **`cortina`**: Controla a iluminação natural e privacidade (Abrir/Fechar).
5. **`fechadura`**: Controla o acesso físico à residência (Trancar/Destrancar/Abrir).

### ⚙️ Artefatos (Ambiente)

O ambiente é simulado através de interfaces Java (Swing) usando **CArtAgO** (em `src/env/artifacts/`):

* Interfaces gráficas para cada dispositivo para visualizar o estado atual.
* Simulação de sensores (ex: sensor de presença na câmera).
* Logs de operação detalhados no console.

---

## 🚀 Cenários Implementados

O sistema reage automaticamente a três situações principais baseadas na entrada da **Câmera**:

### 1. Chegada do Proprietário (Boas-vindas)

Quando o proprietário chega em casa, o sistema prepara o ambiente para o seu conforto.

* **Gatilho:** Pessoa: `Jonas` | Local: `frente`
* **Ações:**
  * 🚪 Porta: Destranca e abre.
  * ❄️ Ar Condicionado: Liga e ajusta para **25°C**.
  * 💡 Lâmpada: Liga.
  * 🪟 Cortina: Abre totalmente (100%).

### 2. Saída do Proprietário

Quando o proprietário deixa a residência, o sistema entra em modo de economia e segurança passiva.

* **Gatilho:** Pessoa: `Jonas` | Local: `saida`
* **Ações:**
  * 🚪 Porta: Fecha e tranca.
  * ❄️ Ar Condicionado: Desliga.
  * 💡 Lâmpada: Desliga.
  * 🪟 Cortina: Fecha totalmente (0%).

### 3. Modo de Segurança (Intruso)

Se uma pessoa desconhecida é detectada, o sistema ativa o "Modo Pânico" para dificultar a permanência do intruso.

* **Gatilho:** Pessoa: `[Qualquer nome ≠ Jonas]` | Local: `[Qualquer]`
* **Ações:**
  * 🚨 Alerta: Mensagem de segurança enviada a todos os agentes (Broadcast).
  * 🚪 Porta: Fecha e tranca imediatamente.
  * ❄️ Ar Condicionado: Liga em temperatura extrema (**0°C**) para congelar o ambiente.
  * 💡 Lâmpada: Apaga (para dificultar a visão).
  * 🪟 Cortina: Fecha.

---

## 🛠️ Como Rodar

### Pré-requisitos

* Java JDK 17 ou superior.
* Gradle.

### Execução

1. Abra o terminal na raiz do projeto.
2. Execute o comando do Gradle:

    ```bash
    ./gradlew run
    ```

3. Várias janelas pequenas se abrirão (Câmera, Ar Condicionado, Fechadura, etc.). Organize-as na tela para visualizar a simulação.

### Como Testar

Utilize a janela da **Câmera** para simular os eventos:

1. **Teste de Chegada:**
    * Campo Pessoa: `Jonas` (Respeite a letra maiúscula)
    * Campo Local: `frente`
    * Clique em **OK**.

2. **Teste de Saída:**
    * Campo Pessoa: `Jonas` (Respeite a letra maiúscula)
    * Campo Local: `saida`
    * Clique em **OK**.

3. **Teste de Intruso:**
    * Campo Pessoa: `Ladrao`
    * Campo Local: `sala`
    * Clique em **OK**.

---

## 📝 Logs e Debug

O sistema gera logs detalhados no terminal e também salva arquivos de log na pasta `log/`.

* Verifique o console para ver a troca de mensagens entre os agentes (BDI).

---

## 📄 Estrutura de Arquivos

* `src/agt/`: Código fonte dos agentes (.asl).
* `src/env/artifacts/`: Código Java dos artefatos (sensores e atuadores).
* `main.jcm`: Arquivo de configuração principal do projeto JaCaMo.
