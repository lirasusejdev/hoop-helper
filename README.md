# 🛠️ Hoop Helper

Este repositório contém scripts úteis para interagir com o **Hoop**, facilitando o acesso a instâncias e a execução de comandos.

---

## 📜 Índice

1. [Script Interativo](#-script-interativo)
2. [Como Usar](#-como-usar)
3. [Variações Úteis](#-variações-úteis)
   - [Opção 1: Menu Simples com `select`](#-opção-1-menu-simples-com-select-do-bash)
   - [Opção 2: Menu Turbo com `fzf`](#-opção-2-menu-turbo-com-fzf)
4. [Dica: Manter Instâncias em um Arquivo](#-dica-manter-instâncias-em-um-arquivo)

---

## 🛠️ Script Interativo

### Exemplo: `run-hoop.sh`

Um script simples para login no Hoop, conexão com uma instância e execução de comandos.

````bash
#!/bin/bash

echo "🔐 Fazendo login no Hoop..."
hoop login

echo "🔗 Conectando à conexão rsm-prw-sw..."
hoop connection rsm-prw-sw

# Pergunta qual instância você quer acessar
read -p "Digite o account path da instância (ex: 'client-x/instance-y'): " instance

# Espera um pouco até a conexão estar ativa (ajuste se necessário)
sleep 2

# Executa o comando desejado (ex: 'deal') dentro da instância
echo "🚀 Executando comando 'deal' na instância $instance..."
hoop exec "$instance" -- deal
````

---

## ✅ Como Usar

1. Crie um arquivo chamado `run-hoop.sh`.
2. Copie o conteúdo do script acima.
3. Torne o script executável:

````bash
chmod +x run-hoop.sh
````

4. Execute o script:

````bash
./run-hoop.sh
````

O script pedirá o caminho da instância (exemplo: `account-name/dev-01`) e executará automaticamente o comando `deal`.

---

## 🧠 Variações Úteis

### 1. Executar outros comandos além de `deal`

Adapte o script para aceitar comandos personalizados.

### 2. Passar a instância como argumento

Execute o script diretamente com a instância como argumento:

````bash
./run-hoop.sh account-x/instancia-y
````

### 3. Usar menus interativos

Implemente menus interativos com `select` ou `fzf` para facilitar a escolha da instância.

---

## 💡 Opção 1: Menu Simples com `select` do Bash

### ✅ Vantagens

- Funciona em qualquer terminal, sem necessidade de instalar ferramentas adicionais.
- Simples e direto.

### Script:

````bash
#!/bin/bash

echo "🔐 Fazendo login no Hoop..."
hoop login

echo "🔗 Conectando à conexão rsm-prw-sw..."
hoop connection rsm-prw-sw

# Lista de instâncias mais comuns
INSTANCIAS=(
  "cliente-a/dev-01"
  "cliente-b/staging"
  "cliente-c/prod"
  "cliente-d/dev-02"
  "Outra (digitar manualmente)"
)

echo "📦 Escolha a instância:"
select INSTANCIA in "${INSTANCIAS[@]}"; do
  if [[ $INSTANCIA == "Outra (digitar manualmente)" ]]; then
    read -p "Digite o path da instância: " INSTANCIA
  fi
  break
done

# Comando a ser executado
read -p "💻 Qual comando deseja executar na instância? (padrão: deal): " COMANDO
COMANDO=${COMANDO:-deal}

echo "🚀 Executando '$COMANDO' na instância $INSTANCIA..."
hoop exec "$INSTANCIA" -- $COMANDO
````

---

## 🌟 Opção 2: Menu Turbo com `fzf`

### ✅ Vantagens

- Interface interativa incrível.
- Busca em tempo real com o teclado.
- Ideal para desenvolvedores avançados.

### 🚧 Pré-requisito

Instale o `fzf`:

- **Ubuntu**:

````bash
sudo apt install fzf
````

- **macOS** (com `brew`):

````bash
brew install fzf
````

### Script:

````bash
#!/bin/bash

echo "🔐 Login no Hoop..."
hoop login

echo "🔗 Conectando com rsm-prw-sw..."
hoop connection rsm-prw-sw

# Lista de instâncias (pode vir de um arquivo ou comando futuro)
INSTANCIAS=$(cat <<EOF
cliente-a/dev-01
cliente-b/staging
cliente-c/prod
cliente-d/dev-02
EOF
)

# Seleciona com fzf
INSTANCIA=$(echo "$INSTANCIAS" | fzf --prompt="Escolha a instância: ")

# Se não selecionou nada, cancela
[[ -z "$INSTANCIA" ]] && echo "❌ Nenhuma instância selecionada." && exit 1

# Comando opcional
read -p "💻 Comando a ser executado (padrão: deal): " COMANDO
COMANDO=${COMANDO:-deal}

echo "🚀 Executando '$COMANDO' na instância $INSTANCIA..."
hoop exec "$INSTANCIA" -- $COMANDO
````

---

## 🧠 Dica: Manter Instâncias em um Arquivo

Você pode criar um arquivo `.instancias.txt` com a lista de instâncias mais usadas:

````bash
cliente-x/dev-01
cliente-x/prod
cliente-y/dev
cliente-z/staging
````

E no script, carregue as instâncias diretamente:

````bash
INSTANCIAS=$(cat .instancias.txt)
````

---

## 📌 Conclusão

Com esses scripts e variações, você pode automatizar e simplificar o uso do **Hoop**, adaptando as soluções às suas necessidades. Escolha a abordagem que melhor se encaixa no seu fluxo de trabalho!