#!/bin/bash

echo "🔐 Fazendo login no Hoop..."
hoop login

echo "🔗 Conectando à conexão rsm-prw-sw..."
hoop connection rsm-prw-sw

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

read -p "💻 Qual comando deseja executar na instância? (padrão: deal): " COMANDO
COMANDO=${COMANDO:-deal}

echo "🚀 Executando '$COMANDO' na instância $INSTANCIA..."
hoop exec "$INSTANCIA" -- $COMANDO