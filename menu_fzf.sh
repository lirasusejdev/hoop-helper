#!/bin/bash

echo "🔐 Login no Hoop..."
hoop login

echo "🔗 Conectando com rsm-prw-sw..."
hoop connection rsm-prw-sw

INSTANCIAS=$(cat .instancias.txt)

INSTANCIA=$(echo "$INSTANCIAS" | fzf --prompt="Escolha a instância: ")

[[ -z "$INSTANCIA" ]] && echo "❌ Nenhuma instância selecionada." && exit 1

read -p "💻 Comando a ser executado (padrão: deal): " COMANDO
COMANDO=${COMANDO:-deal}

echo "🚀 Executando '$COMANDO' na instância $INSTANCIA..."
hoop exec "$INSTANCIA" -- $COMANDO